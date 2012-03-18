From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [GSoC] Improving parallelism
Date: Sun, 18 Mar 2012 11:42:19 +0700
Message-ID: <CACsJy8BFcx0dR12MYtZiHsmh3=z71NoT9CuL9Xsgq6bca-Q_Cg@mail.gmail.com>
References: <CANELHzNc+28ZDiZ69zv3X0DJMf0DTkiZXQD1-32Wsy-=vtWDhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Felipe Tanus <fotanus@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 05:43:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S97xJ-00062L-Es
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 05:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab2CREmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 00:42:51 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:51151 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab2CREmu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 00:42:50 -0400
Received: by wejx9 with SMTP id x9so4992906wej.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 21:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dpStvzymnX0v1BTZdY2zgDEV+53ITTXyBXnH9eQnNq0=;
        b=XAbnnwMUav87QlQWUlRFlHwvDcJKei+reK5okGRGcOZHVMwNrbuUp5TOXEv259IrY9
         FGWsQdb3Fc53DRb4+dkXQFxhZXzkNn+L07pOwyQh8dXltfDeTKlHdyxDIryZ0CS3EP0P
         QBkcJU/6OENFrv5bnpxl5+dpcalgFZuFADxfxKUH4Y1RzD6oyo4AWeBhqn/w6xlApFwJ
         U0ker9Igy9nTKTFHakR97XHbr61/LeEvWRnLI0D/ytOqxLBju986YzXPIREvJAIB//bY
         mQPw5dezT9LTVlNAtx+gkx5SqpTgr4owlUBEwpnhDqKrUnnPYhPEgVToU/j5EZVgXiTB
         7+iA==
Received: by 10.216.135.103 with SMTP id t81mr4596256wei.113.1332045769438;
 Sat, 17 Mar 2012 21:42:49 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Sat, 17 Mar 2012 21:42:19 -0700 (PDT)
In-Reply-To: <CANELHzNc+28ZDiZ69zv3X0DJMf0DTkiZXQD1-32Wsy-=vtWDhw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193369>

On Sun, Mar 18, 2012 at 5:18 AM, Felipe Tanus <fotanus@gmail.com> wrote:
> I find the idea of the proposal straight-forward, and no doubts pop up
> in my mind, except on what commands can I work on. The idea described
> in the wiki tells that the commands "git grep --cached" and "git grep
> COMMIT" need this improvement, and most likely "git diff" and "git log

Note that if you improve diff machinery, many commands will benefit
(add, apply, checkout, merge, status)

> -p" need too. That is a good start, but if you know already other
> commands that might benefit from this parallelism, please tell me in
> order for me to include in my proposal.

"git blame" (I think, I don't use this command much) and "git fsck".
"git index-pack" is getting multithread support soon (you can search
mail archive), but even then I think there's still room for further
improvements (i.e. parallelize the hashing code in the first phase of
checking the pack).

If that's not enough, you may want to investigate whether multithread
support can speed up "git rev-list --objects --all" without adding too
much complexity. Speeding up this can also be achieved by implementing
pack format version 4 (current version is 3). But that's a bigger work
and may need more time to land.
-- 
Duy

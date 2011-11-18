From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: A flaw in dep generation with gcc -MMD?
Date: Fri, 18 Nov 2011 21:12:02 +0700
Message-ID: <CACsJy8CKmjq01KoLRzOnnaf6RwFCQJfjxziqKTZW9HDyd8CagA@mail.gmail.com>
References: <CACsJy8BZMDyf4MCiKxPJ5Z+XS+C-MC82SpMFyWgiXmb9xCnScw@mail.gmail.com>
 <20111118034142.GA25228@elie.hsd1.il.comcast.net> <CACsJy8A44PFtYrm8NQU+48sVkOe8mjJyO9opO5-TwRtAd-TKsQ@mail.gmail.com>
 <buor516m3w7.fsf@dhlpc061.dev.necel.com> <CACsJy8BuCdT3rRjc5u6Ex5RRgSbL_0SFF0GW-dTGqet4sG2cwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Nov 18 15:12:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRPBK-0005VS-Qi
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 15:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757273Ab1KROMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 09:12:35 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35451 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756830Ab1KROMe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 09:12:34 -0500
Received: by bke11 with SMTP id 11so3463987bke.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 06:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=p8BZSR2JWpNQEenXEQnBT/c3r49iMbIk2R5/hq48Rr8=;
        b=gScJegccMau5Q4jSr7CEqvIXX0feuk7giNCMrSJP/sVdGBlFfZ0J6nUb+cA3K9/Ad+
         FOvXDVrntDYSYI76mYEJO9yEtaTYC3Wf/OS0S0PoWGcUIuLQqvrvkTofVejfzKuLeAql
         1shwTkwVrspHnlJrr5/v9PtFQcws+EUYR49O0=
Received: by 10.205.131.3 with SMTP id ho3mr3592332bkc.11.1321625553150; Fri,
 18 Nov 2011 06:12:33 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Fri, 18 Nov 2011 06:12:02 -0800 (PST)
In-Reply-To: <CACsJy8BuCdT3rRjc5u6Ex5RRgSbL_0SFF0GW-dTGqet4sG2cwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185662>

On Fri, Nov 18, 2011 at 6:34 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> OK it's not gcc problem. I upgraded to 4.5.3 and still had the same
> problem. I used ccache though. Without ccache, gcc produced correct
> .o.d files.

"gcc -MF depfile -MMD -MP -c -o path/to/file.o" will produce "depfile"
with target given by "-o". When ccache runs, it executes "gcc -MF
depfile -MMD -MP -E" instead to get the final content for hashing.
Notice that "-c -o" combination is replaced by "-E". The latter
produces target without leading path.

Not sure if I should report this to ccache or gcc. In the meantime,
may be we should recognize the situation and switch off
COMPUTE_HEADER_DEPENDENCIES when ccache is used (maybe hard).
-- 
Duy

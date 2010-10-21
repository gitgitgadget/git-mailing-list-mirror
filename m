From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: [PATCH] git-gui: support core.whitespace rules in diff view
Date: Thu, 21 Oct 2010 14:36:36 +0200
Message-ID: <AANLkTikG0_9+Gjnhehf8436Kw089Zd-XaSdSOP-J6_yD@mail.gmail.com>
References: <AANLkTikttRVeE+PVUJGiLERC=qdoxSH1oyXa5HLXoW0N@mail.gmail.com>
	<87hbgh7paf.fsf@fox.patthoyts.tk>
	<AANLkTimrrxbKSYib7g0O5TXXwt5yDTdkt_bycs69mKT7@mail.gmail.com>
	<87pqv4fqqz.fsf_-_@fox.patthoyts.tk>
	<7vy69stop2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Oct 21 14:36:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8uNu-0003Qe-Rt
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 14:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757735Ab0JUMgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 08:36:38 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57482 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385Ab0JUMgh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 08:36:37 -0400
Received: by pvh1 with SMTP id 1so199795pvh.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 05:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=WhuQAnyCmDiqQC5si8ty57gTXatPBIyPd5awRXK8Ys8=;
        b=x0TmxaQuWbZcbs3DS+gfGiFFzkw/Ytv/LXXQggSKoi4dBj5Wx9oeyvcnTznRvAbW9i
         ijJxomaLPrWPEFT2lrnVRQ1R10DaX75MApxkrr3ruWpy+KGl36Akh8nb53KY8wl6Tay3
         pz/iyJAbGwBczyuB/JcYyrsSMa33mxgEZdhhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Gz5K21F2bT8/FvdZtxjURI3NYDMyKbIRpTjZhp+LIQd8lQAy6QMfUAUpLJH0zGLsbk
         BT04Zp6oThAjxq90siqNmmwO6VupBb3DmSn7oFPNcuZqTetnFBDYT2x2x3jmafVoyS4K
         BaEUSnwyXM37TOAk46aIiYtVuRS+/KYmg5QQc=
Received: by 10.142.155.1 with SMTP id c1mr600850wfe.194.1287664596689; Thu,
 21 Oct 2010 05:36:36 -0700 (PDT)
Received: by 10.220.76.74 with HTTP; Thu, 21 Oct 2010 05:36:36 -0700 (PDT)
In-Reply-To: <7vy69stop2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159496>

On Thu, Oct 21, 2010 at 1:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pat Thoyts <patthoyts@users.sourceforge.net> writes:
>
>> This is a rather more complete implementation of whitespace highlighting
>> according to the core.whitespace setting. The diff view whitespace
>> highlights should match what you see with 'git diff' when color is
>> enabled for all the whitespace rules except cr-at-eol where there is
>> currently a rule to hide these.
>>
>> Suggested-by: Tor Arvid Lund <torarvid@gmail.com>
>> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
>> ---
>
> This might be a very stupid question, but isn't it an easier-to-maintain
> option to let underlying "git diff" color its output and convert the ANSI
> coloring to whatever Tcl wants to use, especially in the long run, instead
> of trying to replicate the logic to check whitespace breakages here?

Hi Pat, and thanks again for doing the Tcl hacking :)

I did a quick test (with core.whitespace unset, so the defaults should
be used). I wonder if there is a little bug somewhere else in git-gui.
If I have committed a line like this:

............Hello world

and change it to:

........*Hello world

I used '.' to indicate Space, and '*' to indicate Tab, so I changed 4
spaces to one tab character. As I understand space-before-tab, this
should render 8 red spaces, 1 white Tab, and then "Hello world". But
instead I get 9 white spaces... So the tab gets converted to a space
(I verified that it was not my editor that converted it - it really is
8 SP and 1 TAB).

If I change it to
***Hello world
so that there are no leading spaces, then the Tabs do not get converted.

Can you reproduce this? I have applied your patch on top of Junio's
master and build on msysgit on Vista 64 (if that matters).


Btw, I almost feel bad saying this after you implemented my
suggestion, but Junio's suggestion to parse the ANSI escapes seems
quite clever, doesn't it?

Have a good day.

-Tor Arvid-

From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: support core.whitespace rules in diff view
Date: Fri, 22 Oct 2010 16:18:06 +0100
Message-ID: <87lj5qtfwx.fsf@fox.patthoyts.tk>
References: <AANLkTikttRVeE+PVUJGiLERC=qdoxSH1oyXa5HLXoW0N@mail.gmail.com>
	<87hbgh7paf.fsf@fox.patthoyts.tk>
	<AANLkTimrrxbKSYib7g0O5TXXwt5yDTdkt_bycs69mKT7@mail.gmail.com>
	<87pqv4fqqz.fsf_-_@fox.patthoyts.tk>
	<7vy69stop2.fsf@alter.siamese.dyndns.org>
	<AANLkTikG0_9+Gjnhehf8436Kw089Zd-XaSdSOP-J6_yD@mail.gmail.com>
	<8762wve5k2.fsf@fox.patthoyts.tk>
	<AANLkTimSrQ07pPKJ=4H+JL=TpGd7vJD63eea=waATiru@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 17:18:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9JO3-0005oV-4N
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 17:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757361Ab0JVPSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 11:18:25 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:59507 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757141Ab0JVPSY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Oct 2010 11:18:24 -0400
Received: from [172.23.170.144] (helo=anti-virus03-07)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1P9JNr-0005zp-O6; Fri, 22 Oct 2010 16:18:19 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out6.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1P9JNe-0001aq-U2; Fri, 22 Oct 2010 16:18:06 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 34AC221F28; Fri, 22 Oct 2010 16:18:06 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <AANLkTimSrQ07pPKJ=4H+JL=TpGd7vJD63eea=waATiru@mail.gmail.com>
	(Tor Arvid Lund's message of "Fri, 22 Oct 2010 14:00:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159699>

Tor Arvid Lund <torarvid@gmail.com> writes:

>On Thu, Oct 21, 2010 at 8:58 PM, Pat Thoyts
><patthoyts@users.sourceforge.net> wrote:
>> Tor Arvid Lund <torarvid@gmail.com> writes:
><snip>
>>>I did a quick test (with core.whitespace unset, so the defaults should
>>>be used). I wonder if there is a little bug somewhere else in git-gui.
>>>If I have committed a line like this:
>>>
>>>............Hello world
>>>
>>>and change it to:
>>>
>>>........*Hello world
>>>
>>>I used '.' to indicate Space, and '*' to indicate Tab, so I changed 4
>>>spaces to one tab character. As I understand space-before-tab, this
>>>should render 8 red spaces, 1 white Tab, and then "Hello world". But
>>>instead I get 9 white spaces... So the tab gets converted to a space
>>>(I verified that it was not my editor that converted it - it really is
>>>8 SP and 1 TAB).
>>
>> This is caused by the tabstyle being defaulted to 'tabular'. This means
>> the first tab on a line extends to the first tab position and if that
>> lies to the left then the width of a single space is added. Looks like
>> this widget should be using -tabstyle wordprocessor which would do what
>> you expect and move to the next tab position.
>>
>> It is still a tab - just the display width looks wrong.
><snap>
>
>Ok. I tried this, which seems to make it better:
>
>diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
>index 31ca47d..65d5f2a 100755
>--- a/git-gui/git-gui.sh
>+++ b/git-gui/git-gui.sh
>@@ -3283,6 +3283,7 @@ text $ui_diff -background white -foreground black \
>        -borderwidth 0 \
>        -width 80 -height 5 -wrap none \
>        -font font_diff \
>+       -tabstyle wordprocessor \
>        -xscrollcommand {.vpane.lower.diff.body.sbx set} \
>        -yscrollcommand {.vpane.lower.diff.body.sby set} \
>        -state disabled
>
>(this goes on top of your most recent patch from an hour ago)

I guess I should have mentioned - I already pushed such a patch
to git-gui.git's master.

cdd321a git-gui: use wordprocessor tab style to ensure tabs work as expected

Thanks anyway :)
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD

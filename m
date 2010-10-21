From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: support core.whitespace rules in diff view
Date: Thu, 21 Oct 2010 19:58:37 +0100
Message-ID: <8762wve5k2.fsf@fox.patthoyts.tk>
References: <AANLkTikttRVeE+PVUJGiLERC=qdoxSH1oyXa5HLXoW0N@mail.gmail.com>
	<87hbgh7paf.fsf@fox.patthoyts.tk>
	<AANLkTimrrxbKSYib7g0O5TXXwt5yDTdkt_bycs69mKT7@mail.gmail.com>
	<87pqv4fqqz.fsf_-_@fox.patthoyts.tk>
	<7vy69stop2.fsf@alter.siamese.dyndns.org>
	<AANLkTikG0_9+Gjnhehf8436Kw089Zd-XaSdSOP-J6_yD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 20:59:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P90M4-0006RV-M4
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 20:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757539Ab0JUS7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 14:59:04 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:38722 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757527Ab0JUS7B (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 14:59:01 -0400
Received: from [172.23.170.144] (helo=anti-virus03-07)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1P90Lr-0007qD-Oh; Thu, 21 Oct 2010 19:58:59 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out6.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1P90LX-0003ZV-Qs; Thu, 21 Oct 2010 19:58:39 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 43D5224CDB; Thu, 21 Oct 2010 19:58:37 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <AANLkTikG0_9+Gjnhehf8436Kw089Zd-XaSdSOP-J6_yD@mail.gmail.com>
	(Tor Arvid Lund's message of "Thu, 21 Oct 2010 14:36:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159539>

Tor Arvid Lund <torarvid@gmail.com> writes:

>On Thu, Oct 21, 2010 at 1:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Pat Thoyts <patthoyts@users.sourceforge.net> writes:
>>
>>> This is a rather more complete implementation of whitespace highlighting
>>> according to the core.whitespace setting. The diff view whitespace
>>> highlights should match what you see with 'git diff' when color is
>>> enabled for all the whitespace rules except cr-at-eol where there is
>>> currently a rule to hide these.
>>>
>>> Suggested-by: Tor Arvid Lund <torarvid@gmail.com>
>>> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
>>> ---
>>
>> This might be a very stupid question, but isn't it an easier-to-maintain
>> option to let underlying "git diff" color its output and convert the ANSI
>> coloring to whatever Tcl wants to use, especially in the long run, instead
>> of trying to replicate the logic to check whitespace breakages here?
>
>Hi Pat, and thanks again for doing the Tcl hacking :)
>
>I did a quick test (with core.whitespace unset, so the defaults should
>be used). I wonder if there is a little bug somewhere else in git-gui.
>If I have committed a line like this:
>
>............Hello world
>
>and change it to:
>
>........*Hello world
>
>I used '.' to indicate Space, and '*' to indicate Tab, so I changed 4
>spaces to one tab character. As I understand space-before-tab, this
>should render 8 red spaces, 1 white Tab, and then "Hello world". But
>instead I get 9 white spaces... So the tab gets converted to a space
>(I verified that it was not my editor that converted it - it really is
>8 SP and 1 TAB).

This is caused by the tabstyle being defaulted to 'tabular'. This means
the first tab on a line extends to the first tab position and if that
lies to the left then the width of a single space is added. Looks like
this widget should be using -tabstyle wordprocessor which would do what
you expect and move to the next tab position.

It is still a tab - just the display width looks wrong.

>
>If I change it to
>***Hello world
>so that there are no leading spaces, then the Tabs do not get converted.
>Can you reproduce this? I have applied your patch on top of Junio's
>master and build on msysgit on Vista 64 (if that matters).
>
>
>Btw, I almost feel bad saying this after you implemented my
>suggestion, but Junio's suggestion to parse the ANSI escapes seems
>quite clever, doesn't it?

Indeed - see my other post for an implementation.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD

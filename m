From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: [PATCH] git-gui: support core.whitespace rules in diff view
Date: Fri, 22 Oct 2010 14:00:22 +0200
Message-ID: <AANLkTimSrQ07pPKJ=4H+JL=TpGd7vJD63eea=waATiru@mail.gmail.com>
References: <AANLkTikttRVeE+PVUJGiLERC=qdoxSH1oyXa5HLXoW0N@mail.gmail.com>
	<87hbgh7paf.fsf@fox.patthoyts.tk>
	<AANLkTimrrxbKSYib7g0O5TXXwt5yDTdkt_bycs69mKT7@mail.gmail.com>
	<87pqv4fqqz.fsf_-_@fox.patthoyts.tk>
	<7vy69stop2.fsf@alter.siamese.dyndns.org>
	<AANLkTikG0_9+Gjnhehf8436Kw089Zd-XaSdSOP-J6_yD@mail.gmail.com>
	<8762wve5k2.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 22 14:00:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9GIY-0005Lo-Hf
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 14:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756388Ab0JVMAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 08:00:25 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51270 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756228Ab0JVMAX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 08:00:23 -0400
Received: by gxk23 with SMTP id 23so319665gxk.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 05:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ODl3lwgRaaXvDuGaHxdGSgvAg1oKMqqBk/XPpNb/HEg=;
        b=bF6OUQfwkCVvGN6eMXMDmFtc3ejCccfGNPXTQlwtzZcHPEChCNDp9V4u6Te8TnuXh9
         vMwhRJD/v3vNDyOlOHMy92CPxk9nu0M0ap14LFvy/3yocicYZr6nHxo20z2beaKvBpX1
         BrbaWkcSFel2GvqS4rkvCevEhMoqLreeg69BY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=I+EUlTHRkc3GYmsX8SDpl93CuuSW+a2Bbef6J3B8YEe093Dm8Zi7C7RAojwAuB79dL
         uyRS40jOoieUwXKDNW4PHr84rdjA5Uf7m1MPhoU9HDRuCWHVt3rnKc1+XjRd/opyB/AC
         sdVlKSM7EFYLGmSkCk1NKPDpWpDDB/i+TkKRE=
Received: by 10.42.167.9 with SMTP id q9mr1175201icy.165.1287748822905; Fri,
 22 Oct 2010 05:00:22 -0700 (PDT)
Received: by 10.220.76.74 with HTTP; Fri, 22 Oct 2010 05:00:22 -0700 (PDT)
In-Reply-To: <8762wve5k2.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159683>

On Thu, Oct 21, 2010 at 8:58 PM, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> Tor Arvid Lund <torarvid@gmail.com> writes:
<snip>
>>I did a quick test (with core.whitespace unset, so the defaults should
>>be used). I wonder if there is a little bug somewhere else in git-gui.
>>If I have committed a line like this:
>>
>>............Hello world
>>
>>and change it to:
>>
>>........*Hello world
>>
>>I used '.' to indicate Space, and '*' to indicate Tab, so I changed 4
>>spaces to one tab character. As I understand space-before-tab, this
>>should render 8 red spaces, 1 white Tab, and then "Hello world". But
>>instead I get 9 white spaces... So the tab gets converted to a space
>>(I verified that it was not my editor that converted it - it really is
>>8 SP and 1 TAB).
>
> This is caused by the tabstyle being defaulted to 'tabular'. This means
> the first tab on a line extends to the first tab position and if that
> lies to the left then the width of a single space is added. Looks like
> this widget should be using -tabstyle wordprocessor which would do what
> you expect and move to the next tab position.
>
> It is still a tab - just the display width looks wrong.
<snap>

Ok. I tried this, which seems to make it better:

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 31ca47d..65d5f2a 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -3283,6 +3283,7 @@ text $ui_diff -background white -foreground black \
        -borderwidth 0 \
        -width 80 -height 5 -wrap none \
        -font font_diff \
+       -tabstyle wordprocessor \
        -xscrollcommand {.vpane.lower.diff.body.sbx set} \
        -yscrollcommand {.vpane.lower.diff.body.sby set} \
        -state disabled

(this goes on top of your most recent patch from an hour ago)

-Tor Arvid-

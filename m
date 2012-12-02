From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: add a checkbox to control the visibility of tags
Date: Sat, 01 Dec 2012 18:16:25 -0800
Message-ID: <7vlidhmc5i.fsf@alter.siamese.dyndns.org>
References: <1354309737-4280-1-git-send-email-stlman@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?Q?=C5=81ukasz?= Stelmach <stlman@poczta.fm>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Dec 02 03:17:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tez7C-0004TL-5M
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 03:17:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487Ab2LBCQ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Dec 2012 21:16:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61684 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611Ab2LBCQ2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Dec 2012 21:16:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E80BA6D9;
	Sat,  1 Dec 2012 21:16:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ExsYieD3B3FR
	HbR/w//gs0y5p40=; b=bJ02ttsCOkz4D+VJWV8PUps+O2nXEXhGzaG8WO0AGZja
	1mnZ22SGIfx3lgvCMdAfeflvK4yMuSXELszDdxXWyapzjVRUx7/2dsEkwgiCmDFN
	krQ56636+lvOMN7r3/06rNhRlRGKYxkvr4ExKElS+jFpnKL+Vx5mDDiY5R+o30s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TOZGd+
	/09+2pmhKgp6Nzj7opZWvE+jtpJ/oS34DHXmWufeNCaxmfT09X4O9gsgfZtANs5/
	J3dVs/2A2lbUufznFZBmmG0DIYitUJCTyEXUp5ZdjscBzGKFbgvn4ys3s6Okb5Z6
	WJyvTv0mIrIoBo+lL84bTcVXERsE7y92E0Lfk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BC69A6D8;
	Sat,  1 Dec 2012 21:16:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B000A6D7; Sat,  1 Dec 2012
 21:16:26 -0500 (EST)
In-Reply-To: <1354309737-4280-1-git-send-email-stlman@poczta.fm>
 (=?utf-8?Q?=22=C5=81ukasz?= Stelmach"'s message of "Fri, 30 Nov 2012 22:08:57
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46E76E2C-3C26-11E2-96EF-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210990>

=C5=81ukasz Stelmach <stlman@poczta.fm> writes:

> Enable hiding of tags displayed in the tree as yellow labels.
> If a repository is used together with a system like Gerrit
> there may be quite a lot of tags used to control building
> and there may be hardly any place left for commit subjects.
>
> Signed-off-by: =C5=81ukasz Stelmach <stlman@poczta.fm>
> ---

Paul, this patch is not done against your tree (does not have gitk
at the top-level), but other than that, the change mimics the way
existing hideremoes is implemented and looks reasonable to me.

We _may_ want to unify these two "hidestuff" into a list of patterns
that hides any ref that match one of the patterns in the list, e.g.

	set hidestuff {refs/heads/*/* refs/tags/* refs/remotes/*}

may hide all tags, all remote-tracking branches and local branches
that have a slash in their names.

But that is an independent change that can come later.

>  gitk-git/gitk |   23 +++++++++++++++--------
>  1 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index d93bd99..274b46b 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -1754,7 +1754,7 @@ proc readrefs {} {
>      global tagids idtags headids idheads tagobjid
>      global otherrefids idotherrefs mainhead mainheadid
>      global selecthead selectheadid
> -    global hideremotes
> +    global hideremotes hidetags
> =20
>      foreach v {tagids idtags headids idheads otherrefids idotherrefs=
} {
>  	catch {unset $v}
> @@ -1776,6 +1776,7 @@ proc readrefs {} {
>  	    set headids($name) $id
>  	    lappend idheads($id) $name
>  	} elseif {[string match "tags/*" $name]} {
> +	    if {$hidetags} continue
>  	    # this lets refs/tags/foo^{} overwrite refs/tags/foo,
>  	    # which is what we want since the former is the commit ID
>  	    set name [string range $name 5 end]
> @@ -2702,7 +2703,7 @@ proc savestuff {w} {
>      global cmitmode wrapcomment datetimeformat limitdiffs
>      global colors uicolor bgcolor fgcolor diffcolors diffcontext sel=
ectbgcolor
>      global autoselect autosellen extdifftool perfile_attrs markbgcol=
or use_ttk
> -    global hideremotes want_ttk
> +    global hideremotes hidetags want_ttk
> =20
>      if {$stuffsaved} return
>      if {![winfo viewable .]} return
> @@ -2725,6 +2726,7 @@ proc savestuff {w} {
>  	puts $f [list set autosellen $autosellen]
>  	puts $f [list set showneartags $showneartags]
>  	puts $f [list set hideremotes $hideremotes]
> +	puts $f [list set hidetags $hidetags]
>  	puts $f [list set showlocalchanges $showlocalchanges]
>  	puts $f [list set datetimeformat $datetimeformat]
>  	puts $f [list set limitdiffs $limitdiffs]
> @@ -10864,7 +10866,7 @@ proc create_prefs_page {w} {
>  proc prefspage_general {notebook} {
>      global NS maxwidth maxgraphpct showneartags showlocalchanges
>      global tabstop limitdiffs autoselect autosellen extdifftool perf=
ile_attrs
> -    global hideremotes want_ttk have_ttk
> +    global hideremotes hidetags want_ttk have_ttk
> =20
>      set page [create_prefs_page $notebook.general]
> =20
> @@ -10887,6 +10889,9 @@ proc prefspage_general {notebook} {
>      ${NS}::checkbutton $page.hideremotes -text [mc "Hide remote refs=
"] \
>  	-variable hideremotes
>      grid x $page.hideremotes -sticky w
> +    ${NS}::checkbutton $page.hidetags -text [mc "Hide tag labels"] \
> +	-variable hidetags
> +    grid x $page.hidetags -sticky w
> =20
>      ${NS}::label $page.ddisp -text [mc "Diff display options"]
>      grid $page.ddisp - -sticky w -pady 10
> @@ -10988,7 +10993,7 @@ proc doprefs {} {
>      global oldprefs prefstop showneartags showlocalchanges
>      global uicolor bgcolor fgcolor ctext diffcolors selectbgcolor ma=
rkbgcolor
>      global tabstop limitdiffs autoselect autosellen extdifftool perf=
ile_attrs
> -    global hideremotes want_ttk have_ttk
> +    global hideremotes hidetags want_ttk have_ttk
> =20
>      set top .gitkprefs
>      set prefstop $top
> @@ -10997,7 +11002,7 @@ proc doprefs {} {
>  	return
>      }
>      foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
> -		   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
> +		   limitdiffs tabstop perfile_attrs hideremotes hidetags want_ttk}=
 {
>  	set oldprefs($v) [set $v]
>      }
>      ttk_toplevel $top
> @@ -11117,7 +11122,7 @@ proc prefscan {} {
>      global oldprefs prefstop
> =20
>      foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
> -		   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
> +		   limitdiffs tabstop perfile_attrs hideremotes hidetags want_ttk}=
 {
>  	global $v
>  	set $v $oldprefs($v)
>      }
> @@ -11131,7 +11136,7 @@ proc prefsok {} {
>      global oldprefs prefstop showneartags showlocalchanges
>      global fontpref mainfont textfont uifont
>      global limitdiffs treediffs perfile_attrs
> -    global hideremotes
> +    global hideremotes hidetags
> =20
>      catch {destroy $prefstop}
>      unset prefstop
> @@ -11177,7 +11182,8 @@ proc prefsok {} {
>  	  $limitdiffs !=3D $oldprefs(limitdiffs)} {
>  	reselectline
>      }
> -    if {$hideremotes !=3D $oldprefs(hideremotes)} {
> +    if {$hideremotes !=3D $oldprefs(hideremotes) ||
> +        $hidetags !=3D $oldprefs(hidetags)} {
>  	rereadrefs
>      }
>  }
> @@ -11601,6 +11607,7 @@ set cmitmode "patch"
>  set wrapcomment "none"
>  set showneartags 1
>  set hideremotes 0
> +set hidetags 0
>  set maxrefs 20
>  set maxlinelen 200
>  set showlocalchanges 1

From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] patch open-editor-at-top-line
Date: Wed, 08 Aug 2007 19:43:46 +0200
Message-ID: <85wsw5rkfh.fsf@lola.goethe.zz>
References: <20070808151145.GA2897@dnb.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dmitry Monakhov <dmonakhov@openvz.org>
X-From: git-owner@vger.kernel.org Wed Aug 08 19:43:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIpZc-00077q-0R
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 19:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934445AbXHHRnv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 13:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934435AbXHHRnu
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 13:43:50 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:48692 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760781AbXHHRnt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Aug 2007 13:43:49 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 9F09F183AC3;
	Wed,  8 Aug 2007 19:43:47 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id 8B2BE2793FE;
	Wed,  8 Aug 2007 19:43:47 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-025-080.pools.arcor-ip.net [84.61.25.80])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 56AD3225123;
	Wed,  8 Aug 2007 19:43:47 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 9285E1C3C79D; Wed,  8 Aug 2007 19:43:46 +0200 (CEST)
In-Reply-To: <20070808151145.GA2897@dnb.sw.ru> (Dmitry Monakhov's message of "Wed\, 8 Aug 2007 19\:11\:45 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3897/Wed Aug  8 18:50:38 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55334>

Dmitry Monakhov <dmonakhov@openvz.org> writes:

> When i use "guilt series -e" for realy long series file
> it is not confortable always search current top patch line.
> IMHO editor have to start at the top patch automaticaly.
> Btw: open_editor_at_line may be useful in other places
>
> +# usage: open_editor_at_line <editor> <filename> <line>
> +# try to open editor with "filename"" at "line"
> +# different editors use different syntax for start line parameter
> +# so the only thing we can do is just compare with known editiors
> +# and ignore line if editor is unknown.
> +open_editor_at_line()
> +{
> +	editor_name=$1
> +	file_name=$2
> +	line_pos=$3
> +	case "$editor_name" in
> +		"vi" |"vim")
> +			$editor_name $file_name +$line_pos;;
> +		"emacs")
> +			$editor_name $file_mame:$line_pos;;
                                     ^^^^^^^^^^^^^^^^^^^^^^

You have not actually tested this patch.

> +		*)
> +			# editor is unknown, line_pos is just ignored
> +			$editor_name $file_name;;
> +	esac
> +	return $?
> +}
> +

This does not make much sense.  Pretty much every editor that can be
placed into $EDITOR/$VISUAL will understand the

$EDITOR +line filename

line convention (and if they don't, the damage is small).  Certainly
Emacs does so.  I don't know the situation under Windows, but in Unix
this has been the state for editors for eternity.

It turns out that I recently patched the git_editor function in
git-setup-sh.sh to take multiple arguments, and this should come in
handy: just do

git_editor "+$line_pos" "$filename"

and this should open the desired editor at the right line number.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum

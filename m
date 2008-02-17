From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH 01/03] Add helper function for branch tag and commitish to git.el
Date: Sun, 17 Feb 2008 19:30:34 +0100
Message-ID: <87wsp34er9.fsf@wine.dyndns.org>
References: <87wsp8u9m7.dlv@maison.homelinux.org>
	<20080213163002.GA5670@diana.vm.bytemark.co.uk>
	<20080213164356.GA5828@diana.vm.bytemark.co.uk>
	<87zlu4vhon.fsf@osv.gnss.ru> <87lk5ku2wn.dlv_-_@maison.homelinux.org>
	<87ejbcu2gb.dlv_-_@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	Sergei Organov <osv@javad.com>
To: =?utf-8?Q?R=C3=A9mi?= Vanicat <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 19:31:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQoIK-0003ed-MY
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 19:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbYBQSar convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Feb 2008 13:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbYBQSap
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 13:30:45 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:58777 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbYBQSao convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Feb 2008 13:30:44 -0500
Received: from adsl-84-226-48-222.adslplus.ch ([84.226.48.222] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1JQoHd-000526-5q; Sun, 17 Feb 2008 12:30:43 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id DF2CA1E715C; Sun, 17 Feb 2008 19:30:34 +0100 (CET)
In-Reply-To: <87ejbcu2gb.dlv_-_@maison.homelinux.org> (=?utf-8?Q?=22R?=
 =?utf-8?Q?=C3=A9mi?= Vanicat"'s
	message of "Sat, 16 Feb 2008 20:27:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74156>

R=C3=A9mi Vanicat <vanicat@debian.org> writes:

> +(defun git-list-branches (&optional all)
> +  "Return an alist of available branches
> +if all is non-nil, return all branch, otherwise only local one
> +cdr of assoc is non-nil for the current branch
> +nil otherwise"
> +  (let ((branches ()))
> +    (with-temp-buffer
> +      (if all
> +	  (git-run-command-buffer (current-buffer) "branch" "-a")
> +	  (git-run-command-buffer (current-buffer) "branch"))
> +      (goto-char (point-min))
> +      (while (re-search-forward "^\\([ *]\\) \\([^\n]*\\)$" () t)
> +	(push (cons (match-string 2)
> +		    (string=3D (match-string 1) "*"))
> +	      branches)))
> +    (nreverse branches)))

git-run-command-buffer isn't really what you want to use here, look at
how other functions that use a temp-buffer do it. Also that alist thing
is ugly, there are better ways of finding the current branch if we need
it. Besides, you probably want to use git-for-each-ref instead of
git-branch, git-branch is a bit too porcelainish IMO.

--=20
Alexandre Julliard
julliard@winehq.org

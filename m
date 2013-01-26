From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/8] git-remote-testpy: hash bytes explicitly
Date: Sat, 26 Jan 2013 13:44:55 -0800
Message-ID: <7vwquzzkiw.fsf@alter.siamese.dyndns.org>
References: <cover.1358686905.git.john@keeping.me.uk>
 <611a44568bdc969bcfa3d7d870560855e00baf1e.1358686905.git.john@keeping.me.uk>
 <20130126175158.GK7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Jan 26 22:45:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzDYt-0004jW-DD
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 22:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355Ab3AZVo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 16:44:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33922 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754236Ab3AZVo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 16:44:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 528FBB6B9;
	Sat, 26 Jan 2013 16:44:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oXeUwsc0sNpJIPR0N3gcFe/l3xo=; b=wwfOOD
	JF0wxRRdI5/HQhShlP7ESnCac61uV2/fMjM0LUs9UOI83UmL+iK62GyrHf2r5PHS
	HX3AL1QP1GW6VGlMGyyj4WxV419+zSkvZNIf7wNSmkUn0WqEgiGZEzdbAJCpSejl
	SuR2cnMNqOLEpTEJL6vxyn6yk/xHEZnLg3EHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HOThkDonwboWgbyWlccMiookBMFBCZa9
	4mGb4mNpMPDLuXZSTuHf7sExbgk6ueye2LAoOt7DUEXNaqy9/TDdG9UwngUXi+NY
	a6/Azzfyhd8C9V4eda9r8HOU+hen00HMartS4gYN8oHkugRP/gzZBO78AcKSklCY
	T6J4Op1G7vo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 456C9B6B8;
	Sat, 26 Jan 2013 16:44:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C870FB6B7; Sat, 26 Jan 2013
 16:44:56 -0500 (EST)
In-Reply-To: <20130126175158.GK7498@serenity.lan> (John Keeping's message of
 "Sat, 26 Jan 2013 17:51:58 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A04E619E-6801-11E2-829C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214639>

John Keeping <john@keeping.me.uk> writes:

> Junio, can you replace the queued 0846b0c (git-remote-testpy: hash bytes
> explicitly) with this?
>
> I hadn't realised that the "hex" encoding we chose before is a "bytes to
> bytes" encoding so it just fails with an error on Python 3 in the same
> way as the original code.
>
> Since we want to convert a Unicode string to bytes I think UTF-8 really
> is the best option here.

Ahh.  I think it is already in "next", so this needs to be turned
into an incremental to flip 'hex' to 'utf-8', with the justification
being these five lines above.

Thanks for catching.

>
>  git-remote-testpy.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/git-remote-testpy.py b/git-remote-testpy.py
> index d94a66a..f8dc196 100644
> --- a/git-remote-testpy.py
> +++ b/git-remote-testpy.py
> @@ -31,9 +31,9 @@ from git_remote_helpers.git.exporter import GitExporter
>  from git_remote_helpers.git.importer import GitImporter
>  from git_remote_helpers.git.non_local import NonLocalGit
>  
> -if sys.hexversion < 0x01050200:
> -    # os.makedirs() is the limiter
> -    sys.stderr.write("git-remote-testgit: requires Python 1.5.2 or later.\n")
> +if sys.hexversion < 0x02000000:
> +    # string.encode() is the limiter
> +    sys.stderr.write("git-remote-testgit: requires Python 2.0 or later.\n")
>      sys.exit(1)
>  
>  def get_repo(alias, url):
> @@ -45,7 +45,7 @@ def get_repo(alias, url):
>      repo.get_head()
>  
>      hasher = _digest()
> -    hasher.update(repo.path)
> +    hasher.update(repo.path.encode('utf-8'))
>      repo.hash = hasher.hexdigest()
>  
>      repo.get_base_path = lambda base: os.path.join(

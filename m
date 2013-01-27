From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote-testpy: fix patch hashing on Python 3
Date: Sun, 27 Jan 2013 11:49:39 -0800
Message-ID: <7vzjzuv224.fsf@alter.siamese.dyndns.org>
References: <cover.1358686905.git.john@keeping.me.uk>
 <611a44568bdc969bcfa3d7d870560855e00baf1e.1358686905.git.john@keeping.me.uk>
 <20130126175158.GK7498@serenity.lan>
 <7vwquzzkiw.fsf@alter.siamese.dyndns.org> <5104B0B5.1030501@alum.mit.edu>
 <20130127141329.GN7498@serenity.lan> <20130127145056.GP7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 27 20:50:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzYF6-0008MG-3G
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 20:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833Ab3A0Ttp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 14:49:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45064 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755664Ab3A0Ttm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 14:49:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C120FBA93;
	Sun, 27 Jan 2013 14:49:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uniA1PsKzvwwUJLyEl9o7BqqUkI=; b=X7BS8I
	rl/CsghndzUOxoY/9506Iu5oGcpDVmU1AuWsiQfUPHmuqY4gZrKkRf1I759F43cP
	8MWtWMktd9PzGm+2pvHj4oRc6t5GkUgCj3RkUJE5ZIvcWLo7AI+3/XueOgMKQ8lw
	d9M3Xssb/tDt5aBqZ4CbyyAEWM/dNGq6iPla0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TojbUMCsguidVYBeGLROm4s0mvXNkEy5
	Xc822B0LYgn+6EhM9O+HkRhcrY0PkBqwfoWE6rkugDyeTLY8SQmGBA6gUgvOTePT
	Sy+0VzWhng1JnG5rmO9MNK3eLcNnXhnU+9/2FKxB75SVbgESYXVsMYOt/eU3CDS4
	BCdcIguIig8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B42BBBA92;
	Sun, 27 Jan 2013 14:49:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04857BA8F; Sun, 27 Jan 2013
 14:49:40 -0500 (EST)
In-Reply-To: <20130127145056.GP7498@serenity.lan> (John Keeping's message of
 "Sun, 27 Jan 2013 14:50:56 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B094B7E2-68BA-11E2-9128-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214720>

John Keeping <john@keeping.me.uk> writes:

> When this change was originally made (0846b0c - git-remote-testpy: hash
> bytes explicitly , I didn't realised that the "hex" encoding we chose is
> a "bytes to bytes" encoding so it just fails with an error on Python 3
> in the same way as the original code.
>
> It is not possible to provide a single code path that works on Python 2
> and Python 3 since Python 2.x will attempt to decode the string before
> encoding it, which fails for strings that are not valid in the default
> encoding.  Python 3.1 introduced the "surrogateescape" error handler
> which handles this correctly and permits a bytes -> unicode -> bytes
> round-trip to be lossless.
>
> At this point Python 3.0 is unsupported so we don't go out of our way to
> try to support it.
>
> Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---

Thanks; will queue and wait for an Ack from Michael.

Does the helper function need to be named with leading underscore,
though?

> On Sun, Jan 27, 2013 at 02:13:29PM +0000, John Keeping wrote:
>> On Sun, Jan 27, 2013 at 05:44:37AM +0100, Michael Haggerty wrote:
>> > So to handle all of the cases across Python versions as closely as
>> > possible to the old 2.x code, it might be necessary to make the code
>> > explicitly depend on the Python version number, like:
>> > 
>> >     hasher = _digest()
>> >     if sys.hexversion < 0x03000000:
>> >         pathbytes = repo.path
>> >     elif sys.hexversion < 0x03010000:
>> >         # If support for Python 3.0.x is desired (note: result can
>> >         # be different in this case than under 2.x or 3.1+):
>> >         pathbytes = repo.path.encode(sys.getfilesystemencoding(),
>> > 'backslashreplace')
>> >     else
>> >         pathbytes = repo.path.encode(sys.getfilesystemencoding(),
>> > 'surrogateescape')
>> >     hasher.update(pathbytes)
>> >     repo.hash = hasher.hexdigest()
>
> How about this?
>
>  git-remote-testpy.py | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/git-remote-testpy.py b/git-remote-testpy.py
> index c7a04ec..16b0c52 100644
> --- a/git-remote-testpy.py
> +++ b/git-remote-testpy.py
> @@ -36,6 +36,22 @@ if sys.hexversion < 0x02000000:
>      sys.stderr.write("git-remote-testgit: requires Python 2.0 or later.\n")
>      sys.exit(1)
>  
> +
> +def _encode_filepath(path):
> +    """Encodes a Unicode file path to a byte string.
> +
> +    On Python 2 this is a no-op; on Python 3 we encode the string as
> +    suggested by [1] which allows an exact round-trip from the command line
> +    to the filesystem.
> +
> +    [1] http://docs.python.org/3/c-api/unicode.html#file-system-encoding
> +
> +    """
> +    if sys.hexversion < 0x03000000:
> +        return path
> +    return path.encode('utf-8', 'surrogateescape')
> +
> +
>  def get_repo(alias, url):
>      """Returns a git repository object initialized for usage.
>      """
> @@ -45,7 +61,7 @@ def get_repo(alias, url):
>      repo.get_head()
>  
>      hasher = _digest()
> -    hasher.update(repo.path.encode('hex'))
> +    hasher.update(_encode_filepath(repo.path))
>      repo.hash = hasher.hexdigest()
>  
>      repo.get_base_path = lambda base: os.path.join(

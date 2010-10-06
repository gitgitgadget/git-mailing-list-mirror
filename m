From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [RFC/PATCHv5 18/17] gitweb/lib - Add clear() and size() methods
 to caching interface
Date: Wed, 6 Oct 2010 23:56:42 +0100
Message-ID: <AANLkTimpXJT-R5vgdS4SvpuvhVOL-HCJxELMbfRcuqx5@mail.gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com> <1286402526-13143-19-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 00:57:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3cv5-0003hV-EN
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759242Ab0JFW5A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 18:57:00 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47124 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab0JFW47 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 18:56:59 -0400
Received: by bwz11 with SMTP id 11so76942bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=qrk64WD9iDtgSLfJzXU/9tYHPnvf4VjzXtt7hvVyHXI=;
        b=bK+Q5PH1irfhbAN5LANXvBnh7RLmgx05i397xpED/8Gj0fjDwMscL5uvW9h/wdCd6P
         MYP3QqhQXwKAH/74hVWi98k1pcihS61HhUQNYHKOUZzARYW9sSST+pVjabHeVbr2S0xD
         b70RPFNcDZatQrQnwy9//GQ8NjU4O/bh4NZ50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=dXUS0k9yDhK6rbQdSYlTONVTZX9X9XY7Wo1u/RjcHFAtUCibazrx5rPQ3CXoUgYEsp
         mlPCvEB3yTo7uXwlTkPPSoyfeqJfGN6ZiV1mSqlK79YScnJj6O1F2EwiFvOPlunOlc6v
         dQb3lcCZvu/vmKa3Jiu1hIt6YjTzqqD4TOlsw=
Received: by 10.204.119.134 with SMTP id z6mr10152349bkq.193.1286405817898;
 Wed, 06 Oct 2010 15:56:57 -0700 (PDT)
Received: by 10.204.75.155 with HTTP; Wed, 6 Oct 2010 15:56:42 -0700 (PDT)
In-Reply-To: <1286402526-13143-19-git-send-email-jnareb@gmail.com>
X-Google-Sender-Auth: NZWUyNQq0oXuTQfxeAFw9qUkUr0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158342>

On 6 October 2010 23:02, Jakub Narebski <jnareb@gmail.com> wrote:
> Add ->size() method, which following Cache::Cache interface returns
> estimated total size of all entries in whole cache (in the namsepace
> assiciated with give cache instance). =C2=A0Note that ->get_size($key=
)
> returns size of a single entry!
>
> Add ->clear() method, which removes all entries from the namespace
> associated with given cache instance. =C2=A0For safety it requires
> namespace to be set to true value, which means that it cannot be
> empty; therefore default namespace is changed to 'gitweb'.
>
> The ->clear() method should be fairly safe, because it first renames
> directory (which should be atomic), and only then removes it
> (following code from CGI::Driver::File).
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> The only difference from previous version is that a comment about som=
e
> method was moved to earlier commit that introduced it, where it
> belongs.
>
> This patch (implementing "backend") together with next patch
> (implementing "interface") are meant to provide nice web interface to
> safely cleaning (pruning) cache, as described in comments and
> documentation (how to do this manually).
>
> =C2=A0gitweb/lib/GitwebCache/SimpleFileCache.pm | =C2=A0 48 +++++++++=
+++++++++++++++++--
> =C2=A0t/t9503/test_cache_interface.pl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A01 -
> =C2=A02 files changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/gitweb/lib/GitwebCache/SimpleFileCache.pm b/gitweb/lib/G=
itwebCache/SimpleFileCache.pm
> index 2a3d9cf..8f172cb 100644
> --- a/gitweb/lib/GitwebCache/SimpleFileCache.pm
> +++ b/gitweb/lib/GitwebCache/SimpleFileCache.pm
> @@ -20,8 +20,9 @@ package GitwebCache::SimpleFileCache;
> =C2=A0use strict;
> =C2=A0use warnings;
>
> -use File::Path qw(mkpath);
> -use File::Temp qw(tempfile);
> +use File::Path qw(mkpath rmtree);
> +use File::Temp qw(tempfile mktemp);
> +use File::Find qw(find);
> =C2=A0use Digest::MD5 qw(md5_hex);
>
> =C2=A0# by default, the cache nests all entries on the filesystem sin=
gle
> @@ -37,7 +38,7 @@ our $DEFAULT_CACHE_ROOT =3D "cache";
> =C2=A0# by default we don't use cache namespace (empty namespace);
> =C2=A0# empty namespace does not allow for simple implementation of c=
lear() method.
> =C2=A0#
> -our $DEFAULT_NAMESPACE =3D '';
> +our $DEFAULT_NAMESPACE =3D "gitweb";
>
> =C2=A0# .............................................................=
=2E........
> =C2=A0# constructor
> @@ -334,7 +335,7 @@ sub get_size {
> =C2=A0}
>
> =C2=A0# .............................................................=
=2E........
> -# interface methods
> +# interface methods dealing with single item
>
> =C2=A0# Removing and expiring
>
> @@ -427,6 +428,45 @@ sub compute {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return $data;
> =C2=A0}
>
> +# ..................................................................=
=2E...
> +# interface methods dealing with whole namespace
> +
> +# $cache->clear();
> +#
> +# Remove all entries from the namespace.
> +# Namespace must be defined and not empty.
> +sub clear {
> + =C2=A0 =C2=A0 =C2=A0 my $self =3D shift;
> +
> + =C2=A0 =C2=A0 =C2=A0 return unless $self->get_namespace();
> +
> + =C2=A0 =C2=A0 =C2=A0 my $namespace_dir =3D $self->path_to_namespace=
();
> + =C2=A0 =C2=A0 =C2=A0 return if !-d $namespace_dir;
> +
> + =C2=A0 =C2=A0 =C2=A0 my $renamed_dir =3D mktemp($namespace_dir . '.=
XXXX');
> + =C2=A0 =C2=A0 =C2=A0 rename($namespace_dir, $renamed_dir);
> + =C2=A0 =C2=A0 =C2=A0 rmtree($renamed_dir);
> + =C2=A0 =C2=A0 =C2=A0 die "Couldn't remove '$renamed_dir' directory"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if -d $renamed_dir=
;
> +}
> +
> +# $size =3D $cache->size();
> +#
> +# Size of whole names (or whole cache if namespace empty)
> +sub size {
> + =C2=A0 =C2=A0 =C2=A0 my $self =3D shift;
> +
> + =C2=A0 =C2=A0 =C2=A0 my $namespace_dir =3D $self->path_to_namespace=
();
> + =C2=A0 =C2=A0 =C2=A0 return if !-d $namespace_dir;
> +
> + =C2=A0 =C2=A0 =C2=A0 my $total_size =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 my $add_size =3D sub { $total_size +=3D -s $_ =
};
> +
> + =C2=A0 =C2=A0 =C2=A0 File::Find::find({ wanted =3D> $add_size, no_c=
hdir =3D> 1 }, $namespace_dir);
> +
> + =C2=A0 =C2=A0 =C2=A0 return $total_size;
> +}
> +
> =C2=A01;

This looks good to me.

Acked-by:  Thomas Adam <thomas@xteddy.org>

-- Thomas Adam

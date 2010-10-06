From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCHv5 03/17] gitweb/lib - Very simple file based cache
Date: Wed, 6 Oct 2010 23:41:11 +0100
Message-ID: <AANLkTinPCOfknoN4aO_EdPwKorRiM6NU6ep0z_nnNug8@mail.gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com> <1286402526-13143-4-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 00:41:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3cg4-00043I-PU
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759328Ab0JFWl3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 18:41:29 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51633 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759243Ab0JFWl2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 18:41:28 -0400
Received: by bwz11 with SMTP id 11so69547bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=1Lrd3K3S7kLydQaaACqf0CEY0Eje28H2UsrzIsH8Es4=;
        b=GEwFZwaKV4T9st1bwShJrW21lv1Dzl/taNTlC6mzGcerisRkBxaJUPh0GsNzcLNCaC
         ojbl0JPSyom3vPRL8yHnE4jVgpRlHQ4smnMdoJtcdHlBcFwuzF2W+3R0ecBmQYoanRCn
         oJP9ydZLeGDrm7eFWLVLnyN0f74XtVHYdyW74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=E42ecTtdhlvm2qWRpePcYsDTuK9UlIMIM4X2Cxo4bwRB+6LcUd2OgZzMc2fFzpWEkU
         6i9UjJDa7rVgClnIUVidzkuqbtxG8jzNZHhvp+AYLazT/GMWPLdvh3WWsrnPp+rGFBA+
         wtsR688hHLfnMSqBABjnINtO5kfFp9TPLx45M=
Received: by 10.204.180.75 with SMTP id bt11mr10297127bkb.115.1286404886531;
 Wed, 06 Oct 2010 15:41:26 -0700 (PDT)
Received: by 10.204.75.155 with HTTP; Wed, 6 Oct 2010 15:41:11 -0700 (PDT)
In-Reply-To: <1286402526-13143-4-git-send-email-jnareb@gmail.com>
X-Google-Sender-Auth: V8ccMwCO7anNp6idDGMxl_JcE1o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158334>

On 6 October 2010 23:01, Jakub Narebski <jnareb@gmail.com> wrote:
> +# creates get_depth() and set_depth($depth) etc. methods
> +foreach my $i (qw(depth root namespace)) {
> + =C2=A0 =C2=A0 =C2=A0 my $field =3D $i;
> + =C2=A0 =C2=A0 =C2=A0 no strict 'refs';

=46or each item, you'll set "no strict refs"?  This might be better off
outside the loop.  It's still scoped appropriately inside the
subroutine.

> + =C2=A0 =C2=A0 =C2=A0 my $file =3D $self->path_to_key($key);
> + =C2=A0 =C2=A0 =C2=A0 return undef unless (defined $file && -f $file=
);

PBP (Perl Best Practises) will tell you that explicitly returning
undef is discouraged -- "undef" should be reserved for those errors
you cannot handle, not ones you don't want to.

> +
> + =C2=A0 =C2=A0 =C2=A0 # Fast slurp, adapted from File::Slurp::read, =
with unnecessary options removed
> + =C2=A0 =C2=A0 =C2=A0 # via CHI::Driver::File (from CHI-0.33)
> + =C2=A0 =C2=A0 =C2=A0 my $buf =3D '';
> + =C2=A0 =C2=A0 =C2=A0 open my $read_fh, '<', $file
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or return undef;

Ditto.

> + =C2=A0 =C2=A0 =C2=A0 binmode $read_fh, ':raw';
> +
> + =C2=A0 =C2=A0 =C2=A0 my $size_left =3D -s $read_fh;
> +
> + =C2=A0 =C2=A0 =C2=A0 while ($size_left > 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 my $read_cnt =3D s=
ysread($read_fh, $buf, $size_left, length($buf));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return undef unles=
s defined $read_cnt;

Ditto.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last if $read_cnt =
=3D=3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $size_left -=3D $r=
ead_cnt;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #last if $size_lef=
t <=3D 0;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 close $read_fh
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or die "Couldn't c=
lose file '$file' opened for reading: $!";
> + =C2=A0 =C2=A0 =C2=A0 return $buf;
> +}

"use Carp;" would be more useful here, and hence croak() and confess().

> +sub store {
> + =C2=A0 =C2=A0 =C2=A0 my ($self, $key, $data) =3D @_;
> +
> + =C2=A0 =C2=A0 =C2=A0 my $dir;
> + =C2=A0 =C2=A0 =C2=A0 my $file =3D $self->path_to_key($key, \$dir);
> + =C2=A0 =C2=A0 =C2=A0 return undef unless (defined $file && defined =
$dir);

See above.

> + =C2=A0 =C2=A0 =C2=A0 # ensure that directory leading to cache file =
exists
> + =C2=A0 =C2=A0 =C2=A0 if (!-d $dir) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eval { mkpath($dir=
, 0, 0777); 1 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 or die "Couldn't create leading directory '$dir' (mkpath): $!";
> + =C2=A0 =C2=A0 =C2=A0 }

Why is this eval()ed?  It will still return false and set $! appropriat=
ely.

> + =C2=A0 =C2=A0 =C2=A0 # generate a temporary file
> + =C2=A0 =C2=A0 =C2=A0 my ($temp_fh, $tempname) =3D $self->_tempfile_=
to_path($file, $dir);
> + =C2=A0 =C2=A0 =C2=A0 chmod 0666, $tempname
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or warn "Couldn't =
change permissions to 0666 / -rw-rw-rw- for '$tempname': $!";
> +
> + =C2=A0 =C2=A0 =C2=A0 # Fast spew, adapted from File::Slurp::write, =
with unnecessary options removed
> + =C2=A0 =C2=A0 =C2=A0 # via CHI::Driver::File (from CHI-0.33)
> + =C2=A0 =C2=A0 =C2=A0 my $write_fh =3D $temp_fh;
> + =C2=A0 =C2=A0 =C2=A0 binmode $write_fh, ':raw';
> +
> + =C2=A0 =C2=A0 =C2=A0 my $size_left =3D length($data);
> + =C2=A0 =C2=A0 =C2=A0 my $offset =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 while ($size_left > 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 my $write_cnt =3D =
syswrite($write_fh, $data, $size_left, $offset);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return undef unles=
s defined $write_cnt;

Again, with the undef.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $size_left -=3D $w=
rite_cnt;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $offset +=3D $writ=
e_cnt; # =3D=3D length($data);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 close $temp_fh
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or die "Couldn't c=
lose temporary file '$tempname' opened for writing: $!";
> + =C2=A0 =C2=A0 =C2=A0 rename($tempname, $file)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or die "Couldn't r=
ename temporary file '$tempname' to '$file': $!";
> +}
> +
> +# get size of an element associated with the $key (not the size of w=
hole cache)
> +sub get_size {
> + =C2=A0 =C2=A0 =C2=A0 my ($self, $key) =3D @_;
> +
> + =C2=A0 =C2=A0 =C2=A0 my $path =3D $self->path_to_key($key)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or return undef;

Again with the undef

> + =C2=A0 =C2=A0 =C2=A0 if (-f $path) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -s $path;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +# ..................................................................=
=2E...
> +# interface methods
> +
> +# Removing and expiring
> +
> +# $cache->remove($key)
> +#
> +# Remove the data associated with the $key from the cache.
> +sub remove {
> + =C2=A0 =C2=A0 =C2=A0 my ($self, $key) =3D @_;
> +
> + =C2=A0 =C2=A0 =C2=A0 my $file =3D $self->path_to_key($key)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or return undef;
> + =C2=A0 =C2=A0 =C2=A0 return undef unless -f $file;

Again with the undef.

> + =C2=A0 =C2=A0 =C2=A0 unlink($file)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or die "Couldn't r=
emove file '$file': $!";
> +}
> +
> +# Getting and setting
> +
> +# $cache->set($key, $data);
> +#
> +# Associates $data with $key in the cache, overwriting any existing =
entry.
> +# Returns $data.
> +sub set {
> + =C2=A0 =C2=A0 =C2=A0 my ($self, $key, $data) =3D @_;
> +
> + =C2=A0 =C2=A0 =C2=A0 return unless (defined $key && defined $data);

return what?

> + =C2=A0 =C2=A0 =C2=A0 $self->store($key, $data);
> +
> + =C2=A0 =C2=A0 =C2=A0 return $data;
> +}
> +
> +# $data =3D $cache->get($key);
> +#
> +# Returns the data associated with $key. =C2=A0If $key does not exis=
t
> +# or has expired, returns undef.
> +sub get {
> + =C2=A0 =C2=A0 =C2=A0 my ($self, $key) =3D @_;
> +
> + =C2=A0 =C2=A0 =C2=A0 my $data =3D $self->fetch($key)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or return undef;
> +
> + =C2=A0 =C2=A0 =C2=A0 return $data;
> +}
> +
> +# $data =3D $cache->compute($key, $code);
> +#
> +# Combines the get and set operations in a single call. =C2=A0Attemp=
ts to
> +# get $key; if successful, returns the value. =C2=A0Otherwise, calls=
 $code
> +# and uses the return value as the new value for $key, which is then
> +# returned.
> +sub compute {
> + =C2=A0 =C2=A0 =C2=A0 my ($self, $key, $code) =3D @_;
> +
> + =C2=A0 =C2=A0 =C2=A0 my $data =3D $self->get($key);
> + =C2=A0 =C2=A0 =C2=A0 if (!defined $data) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $data =3D $code->(=
$self, $key);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $self->set($key, $=
data);
> + =C2=A0 =C2=A0 =C2=A0 }

Can you guarantee $code here?

unless( defined $code and ref $code eq 'CODE' )
{
        ....
}

Wouldn't it be easier to eval{} this and checj $@?

[...]

-- Thomas Adam

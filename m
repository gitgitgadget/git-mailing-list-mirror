From: =?UTF-8?Q?Nico_Schl=C3=B6mer?= <nico.schloemer@gmail.com>
Subject: Re: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad file descriptor
Date: Thu, 26 Feb 2015 10:09:09 +0100
Message-ID: <CAK6Z60fhyY3wPG6hx7YJ4y7wZsWb=33JhqejmpVBgZLGdB1XMA@mail.gmail.com>
References: <CAK6Z60ciheWOUGOv1sYcA==B2WR1Rs_eMU+9a=R3FBwc_37CyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, Mike <ipso@snappymail.ca>,
	Minty <mintywalker@gmail.com>,
	Valery Yundin <yuvalery@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 10:09:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQuS1-0000GE-I3
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 10:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbbBZJJk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Feb 2015 04:09:40 -0500
Received: from mail-la0-f44.google.com ([209.85.215.44]:35400 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478AbbBZJJb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2015 04:09:31 -0500
Received: by labgm9 with SMTP id gm9so9606206lab.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 01:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=UniOXb2ED9WAMo1+FddFSUEvX8VTZXrtau/ZB4n93cw=;
        b=j80XMmg7vb1zyPtcIq1dOPKphdeMU0NUvToR/TYIMblbI6Pm75BeeS5zhhpBc7kCDb
         zFQS5tApDXdj3YCW1jGtmT+h1cxJbQ1NimTxfHRyrleEmUefeKBQ8xTKa3TldmaemnRP
         IoEzsELI93o90NXR0DAjf5A24qs6WXqxBkLFhOnXfo1GVPMQNSF13+4uao5VdUM+CxLt
         KHahFEm7mCw3YPQc4blJk7RzjJeFO3czJQBs3lGJZqoDfVHWearglv3RydkkZzFexyZO
         9YKsXeobUWWK8YT+yTHZQ28+S1MGLLy7fQddNQtQ5KTn5H2cpsFg/6Do785JYZrsORqg
         6YoQ==
X-Received: by 10.112.24.235 with SMTP id x11mr6485783lbf.18.1424941769849;
 Thu, 26 Feb 2015 01:09:29 -0800 (PST)
Received: by 10.114.11.73 with HTTP; Thu, 26 Feb 2015 01:09:09 -0800 (PST)
In-Reply-To: <CAK6Z60ciheWOUGOv1sYcA==B2WR1Rs_eMU+9a=R3FBwc_37CyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264426>

All,

I applied Kyle's latest patch

> diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
> index 622535e2..96888228 100644
> --- a/perl/Git/SVN/Ra.pm
> +++ b/perl/Git/SVN/Ra.pm
> @@ -391,6 +391,7 @@ sub longest_common_path {
> sub gs_fetch_loop_common {
>         my ($self, $base, $head, $gsv, $globs) =3D @_;
>         return if ($base > $head);
> +       $::_repository->_open_cat_blob_if_needed;
>         my $gpool =3D SVN::Pool->new_default;
>         my $ra_url =3D $self->url;
>         my $reload_ra =3D sub {

alone and this fixes the bug for me. Thanks a lot, Kyle!

Cheers,
Nico

On Thu, Feb 26, 2015 at 12:37 AM, Nico Schl=C3=B6mer
<nico.schloemer@gmail.com> wrote:
> Kyle,
>
> you are absolutely correct, I used the wrong Git installation in my l=
ast
> email. With both your and Eric's patches applied, I'm getting
> ```
> [...]
> r100 =3D e2a9b5baa2cebb18591ecb04ff350410d52f36de (refs/remotes/git-s=
vn)
> Unexpected result returned from git cat-file at
> /home/nschloe/share/perl/5.18.2/Git/SVN/Fetcher.pm line 344.
> Failed to read object 619f9d1d857fb287d06a70c9dac6b8b534d0de6a at
> /home/nschloe/share/perl/5.18.2/Git/SVN/Fetcher.pm line 345, <GEN16> =
line
> 757.
>
> error closing pipe: Bad file descriptor at
> /home/nschloe/libexec/git-core/git-svn line 0.
> error closing pipe: Bad file descriptor at
> /home/nschloe/libexec/git-core/git-svn line 0.
> ```
> where line 344 is
> ```
> $size =3D $::_repository->cat_blob($fb->{blob}, $base);
> ```
> Adding the line in `perl/Git/SVN/Ra.pm` as per your suggestion does n=
ot
> change this.
>
> Cheers,
> Nico
>
>
> On Wed, Feb 25, 2015 at 9:34 PM Kyle J. McKay <mackyle@gmail.com> wro=
te:
>>
>> On Feb 25, 2015, at 07:07, Nico Schl=C3=B6mer wrote:
>>
>> > Thanks Kyle for the patch! I applied it and ran
>> > ```
>> > git svn clone https://geuz.org/svn/gmsh/trunk
>> > ```
>> > Unfortunately, I'm still getting
>> > ```
>> > [...]
>> > r100 =3D e2a9b5baa2cebb18591ecb04ff350410d52f36de (refs/remotes/gi=
t-svn)
>> > error closing pipe: Bad file descriptor at /usr/share/perl5/Git/SV=
N/
>> > Fetcher.pm line 335.
>> > error closing pipe: Bad file descriptor at /usr/share/perl5/Git/SV=
N/
>> > Fetcher.pm line 335.
>> > out pipe went bad at /usr/share/perl5/Git.pm line 955.
>> > ```
>>
>> Are you certain you're running with the patch?  I ask because earlie=
r
>> you sent this:
>>
>> On Jan 31, 2015, at 04:51, Nico Schl=C3=B6mer wrote:
>>
>> > I tried the patch and I still get
>> > ```
>> > [...]
>> > r100 =3D e2a9b5baa2cebb18591ecb04ff350410d52f36de (refs/remotes/gi=
t-svn)
>> > Unexpected result returned from git cat-file at
>> > /home/nschloe/share/perl/5.18.2/Git/SVN/Fetcher.pm line 335.
>> > Failed to read object 619f9d1d857fb287d06a70c9dac6b8b534d0de6a at
>> > /home/nschloe/share/perl/5.18.2/Git/SVN/Fetcher.pm line 336, <GEN1=
6>
>> > line 757.
>> >
>> > error closing pipe: Bad file descriptor at
>> > /home/nschloe/libexec/git-core/git-svn line 0.
>> > error closing pipe: Bad file descriptor at
>> > /home/nschloe/libexec/git-core/git-svn line 0.
>> > ```
>> > when
>> > ```
>> > git svn clone https://geuz.org/svn/gmsh/trunk
>> > ```
>>
>> And as the patch below applies to Fetcher.pm at line 322 and inserts=
 8
>> lines, I do not see how you could be getting the same error message =
at
>> line 335 if the patch was present.  Even if you manually applied it =
by
>> only inserting the two lines of code, the line numbers would be at
>> least 337, not 335 as reported above.  I also notice the path to
>> Fetcher.pm is different from your earlier report.
>>
>> That said, the fact that it happens right after r100 (which is when
>> SVN::Pool::clear is getting called) suggests there's another file
>> handle getting caught up in the SVN::Pool somehow.  (When I try to
>> clone gmsh, I got to r4885 before a server disconnection.)
>>
>> It could be as simple as the open2 call FileHandle result in later
>> perl versions ends up in the SVN::Pool whereas in earlier Perl and/o=
r
>> svn versions it does not.
>>
>> What happens if you add this change on top of the Fetcher.pm change:
>>
>> diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
>> index 622535e2..96888228 100644
>> --- a/perl/Git/SVN/Ra.pm
>> +++ b/perl/Git/SVN/Ra.pm
>> @@ -391,6 +391,7 @@ sub longest_common_path {
>>   sub gs_fetch_loop_common {
>>         my ($self, $base, $head, $gsv, $globs) =3D @_;
>>         return if ($base > $head);
>> +       $::_repository->_open_cat_blob_if_needed;
>>         my $gpool =3D SVN::Pool->new_default;
>>         my $ra_url =3D $self->url;
>>         my $reload_ra =3D sub {
>>
>> -Kyle
>>
>> > Cheers,
>> > Nico
>> >
>> > On Wed, Feb 25, 2015 at 11:20 AM Kyle J. McKay <mackyle@gmail.com>
>> > wrote:
>> > I believe I have been able to track down this problem and implemen=
t a
>> > fix.  Please report back if this patch fixes the problem for you.
>> >
>> > -Kyle
>> >
>> > -- 8< --
>> > Subject: [PATCH] Git::SVN::Fetcher: avoid premature 'svn_hash' tem=
p
>> > file closure
>> >
>> > Since b19138b (git-svn: Make it incrementally faster by minimizing
>> > temp
>> > files, v1.6.0), git-svn has been using the Git.pm temp_acquire and
>> > temp_release mechanism to avoid unnecessary temp file churn and
>> > provide
>> > a speed boost.
>> >
>> > However, that change introduced a call to temp_acquire inside the
>> > Git::SVN::Fetcher::close_file function for an 'svn_hash' temp file=
=2E
>> > Because an SVN::Pool is active at the time this function is called=
, if
>> > the Git::temp_acquire function ends up actually creating a new
>> > FileHandle for the temp file (which it will the first time it's ca=
lled
>> > with the name 'svn_hash') that FileHandle will end up in the SVN::=
Pool
>> > and should that pool have SVN::Pool::clear called on it that
>> > FileHandle
>> > will be closed out from under Git::temp_acquire.
>> >
>> > Since the only call site to Git::temp_acquire with the name 'svn_h=
ash'
>> > is inside the close_file function, if an 'svn_hash' temp file is e=
ver
>> > created its FileHandle is guaranteed to be created in the active
>> > SVN::Pool.
>> >
>> > This has not been a problem in the past because the SVN::Pool was =
not
>> > being cleared.  However, since dfa72fdb (git-svn: reload RA every
>> > log-window-size, v2.2.0) the pool has been getting cleared
>> > periodically
>> > at which point the FileHandle for the 'svn_hash' temp file gets
>> > closed.
>> > Any subsequent calls to Git::temp_acquire for 'svn_hash', however,
>> > succeed without creating/opening a new temporary file since it sti=
ll
>> > has
>> > the now invalid FileHandle in its cache.  Callers that then attemp=
t to
>> > use that FileHandle fail with an error.
>> >
>> > We avoid this problem by making sure the 'svn_hash' temp file is
>> > created
>> > in the same place the 'svn_delta_...' and 'git_blob_...' temp file=
s
>> > are
>> > (and then temp_release'd) so that it can be safely used inside the
>> > close_file function without having its FileHandle end up in an
>> > SVN::Pool
>> > that gets cleared.
>> >
>> > Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
>> > ---
>> >  perl/Git/SVN/Fetcher.pm | 8 ++++++++
>> >  1 file changed, 8 insertions(+)
>> >
>> > diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
>> > index 10edb277..613055a3 100644
>> > --- a/perl/Git/SVN/Fetcher.pm
>> > +++ b/perl/Git/SVN/Fetcher.pm
>> > @@ -322,6 +322,14 @@ sub apply_textdelta {
>> >         # (but $base does not,) so dup() it for reading in close_f=
ile
>> >         open my $dup, '<&', $fh or croak $!;
>> >         my $base =3D $::_repository->temp_acquire("git_blob_${$}_
>> > $suffix");
>> > +       # close_file may call temp_acquire on 'svn_hash', but
>> > because of the
>> > +       # call chain, if the temp_acquire call from close_file end=
s
>> > up being the
>> > +       # call that first creates the 'svn_hash' temp file, then t=
he
>> > FileHandle
>> > +       # that's created as a result will end up in an SVN::Pool
>> > that we clear
>> > +       # in SVN::Ra::gs_fetch_loop_common.  Avoid that by making
>> > sure the
>> > +       # 'svn_hash' FileHandle is already created before close_fi=
le
>> > is called.
>> > +       my $tmp_fh =3D $::_repository->temp_acquire('svn_hash');
>> > +       $::_repository->temp_release($tmp_fh, 1);
>> >
>> >         if ($fb->{blob}) {
>> >                 my ($base_is_link, $size);
>> > --
>>
>

From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv5 07/12] gitweb: remotes view for a single remote
Date: Mon, 27 Sep 2010 09:11:57 +0200
Message-ID: <AANLkTimemfDPdMycasFmqUvk0eF-eD9z7P1RFnitLD9G@mail.gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1285344167-8518-8-git-send-email-giuseppe.bilotta@gmail.com> <201009262255.45959.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 09:12:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P07t4-0002gO-DD
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 09:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758863Ab0I0HMW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 03:12:22 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58541 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758479Ab0I0HMV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 03:12:21 -0400
Received: by iwn5 with SMTP id 5so4542686iwn.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 00:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=7fP5WbZPNWA0lCrhszLVNv5B6t/NoZ4ltonDxYKFXxA=;
        b=hJ83wCKBYiLjfQXdB8rxiXP/p6gmR3KbVhedJedpjjprpw4Du4/SW9la9ViI/96YYO
         xvJIwLnUS/+kHAlpcp5Rqt6RccE9FNeeqKp18cXTQq0xjbEoVULNnjuEAeAEUeYXgJEE
         Eg8ktoBL7SKPEvQjJuk+v2YsLCoJGsg8D6zPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bKpGWZetQj+ev4c1SNCkUcRSuMPpTve4GjoHEjwT0heYa55Je0BEfKZ2szwsXxdu+N
         ef/MtJowAISQFO1F1FQPFp7sy2eoaXz1U2DXoxW9I7WhOGhcF2ce8n1jSc/i6ogEo493
         3KH88Dy+kza3w6z6IPiW8WmAjmI6Jha7OKGfg=
Received: by 10.231.157.212 with SMTP id c20mr8581319ibx.186.1285571541017;
 Mon, 27 Sep 2010 00:12:21 -0700 (PDT)
Received: by 10.231.166.145 with HTTP; Mon, 27 Sep 2010 00:11:57 -0700 (PDT)
In-Reply-To: <201009262255.45959.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157310>

2010/9/26 Jakub Narebski <jnareb@gmail.com>:
> On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:
>
>> If the hash parameter is passed to gitweb, remotes will interpret it=
 as
>> the name of a remote and limit the view the the heads of that remote=
=2E
>
> Errr... I think this commit message needs rewriting to be more clear.
> Perhaps:
>
> =A0When 'remotes' view is passed 'hash' parameter, it would interpret=
e it
> =A0as the name of a remote ...

Can do.

>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>> ---
>> =A0gitweb/gitweb.perl | =A0 25 ++++++++++++++++++++-----
>> =A01 files changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 76cf806..7c62701 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -5547,13 +5547,28 @@ sub git_remotes {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 or die_error(403, "Remote heads view is =
disabled");
>>
>> =A0 =A0 =A0 my $head =3D git_get_head_hash($project);
>> - =A0 =A0 git_header_html();
>> - =A0 =A0 git_print_page_nav('','', $head,undef,$head,format_ref_vie=
ws('remotes'));
>> + =A0 =A0 my $remote =3D $input_params{'hash'};
>
> I am not sure about using 'hash' parameter for that.
>
> On one hand it is a hack that allow us to not worry about adding extr=
a
> code to evaluate_path_info() subroutine, so that natural path_info UR=
L
> of http://git.example.com/repo.git/remotes/<remote> would use <remote=
>
> as name of remote to limit to.

It also spares us the introduction of a new parameter, since I'm not
aware of any of the current parameters that could take this role.

> On the other hand it is abusing semantic of 'hash' parameter. =A0Remo=
te
> name is not revision name or object id.

True. But I cannot think of a use for the hash parameter in remotes
view, and since hash is also used for _named_ refs, it  "kind of"
makes sense to use for a name that is not actually a hash or ref. The
only other option (aside from the use of a new parameter) would be to
use 'hash_base', by reading it as 'base for the ref names' in the
sense that remote refs are 'refs/remote/<base>/name' where the base is
the remote name. But I doubt that's actually more sensible than using
'hash'.

> What makes this issue stronger is the fact that URL is part of API,
> and if we make mistake here, we would have to maintain backward
> compatibility (at least if it appears in a released version).

We _could_ go on the safe side and use a new parameter for this.

>> +
>> + =A0 =A0 git_header_html(undef, undef, 'header_extra' =3D> $remote)=
;
>
> I don't quite like the name of this parameter, and I am not sure
> if I like the API either.
>
>> + =A0 =A0 git_print_page_nav('', '', =A0$head, undef, $head,
>> + =A0 =A0 =A0 =A0 =A0 =A0 format_ref_views($remote ? '' : 'remotes')=
);
>
> Why this change?

As I mentioned in my replies to the other respective patches, I think
it makes sense to make "all remotes" view easily accessible from the
"single remote" view, and there are two ways I can think of: one is
the "extra header text" way, by making the action name before it point
to "all remotes". The other is to enable 'remotes' in the page nav
submenu when we are in single remotes view (which is why I had the
$current in format_ref_views instead of $action, and which is what is
done by this change).  IMO it makes sense to have both ways available,
but I'm open to suggestions about different approaches.

>> =A0 =A0 =A0 git_print_header_div('summary', $project);
>>
>> - =A0 =A0 my @remotelist =3D git_get_heads_list(undef, 'remotes');
>> - =A0 =A0 if (@remotelist) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 git_heads_body(\@remotelist, $head);
>> + =A0 =A0 if (defined $remote) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 # only display the heads in a given remote
>> + =A0 =A0 =A0 =A0 =A0 =A0 my @headslist =3D map {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $ref =3D $_ ;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $ref->{'name'} =3D~ s!^$re=
mote/!!;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $ref
>> + =A0 =A0 =A0 =A0 =A0 =A0 } git_get_heads_list(undef, "remotes/$remo=
te");
>
> Hmmm... do we need this temporary variable? =A0Does it make anything
> more clear?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (@headslist) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git_heads_body(\@headslist=
, $head);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>
> This part is the same (modulo name of variable) in both branches of t=
his
> conditional.
>
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 my @remotelist =3D git_get_heads_list(unde=
f, 'remotes');
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (@remotelist) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git_heads_body(\@remotelis=
t, $head);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 git_footer_html();

Yup, I can make the logic here cleaner and reuse variables (and code)
across the conditionals.

--=20
Giuseppe "Oblomov" Bilotta

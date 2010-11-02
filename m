From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 10/10] gitweb: group remote heads by remote
Date: Tue, 2 Nov 2010 11:49:12 +0100
Message-ID: <AANLkTinyi22OczYuD4urJKkfh8AzyuZoTzvzAvWa1Bo4@mail.gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1287917136-26103-11-git-send-email-giuseppe.bilotta@gmail.com> <201010270232.37961.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 02 11:49:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDEQv-0008RY-Tu
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 11:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723Ab0KBKtf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Nov 2010 06:49:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39772 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab0KBKtd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Nov 2010 06:49:33 -0400
Received: by iwn10 with SMTP id 10so8242704iwn.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 03:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Lw0n92gB98fyNchFRBODIMKqsvWUV4ClkX6RlUR4A0s=;
        b=oPAqnr8YFt4OQRSCWngwhRV6VyRd2tE3X2ugBtE11Bw3yaP536i6k60sDMOJkMVe2E
         4uRzbtjzROGRDaKcb6K3LbNua3CoVGRtpynfkK/T6WD5uJXuICS9g4qytpR3Xfo7WLn5
         kPksKxs7K17jAO33sXKL/e3rXiOTKdjB9dj0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KdRFRdvJje745J5QnRh7/2gjnrrhi2UhtFjqcr9ApzWCBxATugHsdg1TberXJNgaoK
         CZOl1kUgNpTGzVpjNqFvCMiZZbeYJ8nCYJj3DpGo2mI+Dgj08zssGrIW9uXrTcoR8NVj
         eNRkIqnL59HYFD487rz6B88wsdiHPDrNuiAwI=
Received: by 10.231.182.202 with SMTP id cd10mr1674043ibb.68.1288694972991;
 Tue, 02 Nov 2010 03:49:32 -0700 (PDT)
Received: by 10.231.149.141 with HTTP; Tue, 2 Nov 2010 03:49:12 -0700 (PDT)
In-Reply-To: <201010270232.37961.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160515>

2010/10/27 Jakub Narebski <jnareb@gmail.com>:
> On Sun, 24 Oct 2010, Giuseppe Bilotta wrote:
>
>> In remote and summary view, display a block for each remote, with th=
e
>> fetch and push URL(s) as well as the list of the remote heads.
>>
>> In summary view, if the number of remotes is higher than a prescribe=
d
>> limit, only display the first <limit> remotes and their fetch and pu=
sh
>> urls, without any heads information and without grouping.
>
> I like this idea.

Thanks.

> I guess that we can always implement more fancy limiting in the futur=
e
> (e.g. taking into account total number of displayed remote heads).

The limiting seems to be the most debatable part of this patch 8-)

>> +# Returns a hash ref mapping remote names to their fetch and push U=
RLs.
>> +# We return a hash ref rather than a hash so that a simple check wi=
th defined
>> +# can be used to tell apart the "no remotes" case from other kinds =
of
>> +# failures.
>
> Just an idea (it is not necessary to implement it; it has its own
> drawbacks): we could implement here
>
> =A0return wantsarray ? %remotes : \%remotes;
>
> so the caller that wants hash, would get hash; and the one wanting
> reference (to distinguish error from no remotes), would get hash
> reference.

It does simplify the summary view case a little, good point.

>> +#
>> +# It is possible to limit the retrieved remotes either by number
>> +# (specifying a -limit parameter) or by name (-wanted parameter).
>
> I don't quite like limiting when generating, and would prefer do limi=
ting
> on display, especially if not doing limiting would not affect perform=
ance
> much (git command invoked doesn't do limiting, like in case of
> git_get_heads_list / git_get_tags_list or *most important* parse_comm=
its).
>
> Especially if it complicates code that much (see below).
>
> Not doing limiting here, in git_get_remotes_list (or just git_get_rem=
otes)
> would also make API simpler; the single optional argument would be na=
me of
> remote we want to retrieve.

Hm. By the same token, there would be no need to do the limiting even
when trying to get information about a single remote, meaning we could
make the sub totally parameter-less. OTOH, this would make the calling
routine quite more complex (since it would have to check if the key is
there, and then select that single key etc), much more so than
limiting the number of displayed heads. I'll take the numerical
limiting off the routine.

>> +#
>> +# When a single remote is wanted, we cannot use 'git remote show -n=
' because
>> +# that command always work (assuming it's a remote URL if it's not =
defined),
>> +# and we cannot use 'git remote show' because that would try to mak=
e a network
>> +# roundtrip. So the only way to find if that particular remote is d=
efined is to
>> +# walk the list provided by 'git remote -v' and stop if and when we=
 find what
>> +# we want.
>
> I would add 'Implemetation note: ' here, which means start with
> 'Implementation note: When ..." -- but it is not necessary.

Can do that.

>> +
>> +# Takes a hash of remotes as first parameter and fills it by adding=
 the
>> +# available remote heads for each of the indicated remotes.
>> +# A maximum number of heads can also be specified.
>
> All git_get_* subroutines _return_ something; this looks more like fi=
ll_*
> function for me.

I'm not particularly enamored with _get_, fill will do

>
>> +sub git_get_remote_heads {
>> + =A0 =A0 my ($remotes, $limit) =3D @_;
>> + =A0 =A0 my @heads =3D map { "remotes/$_" } keys %$remotes;
>> + =A0 =A0 my @remoteheads =3D git_get_heads_list($limit, @heads);
>> + =A0 =A0 foreach (keys %$remotes) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 my $remote =3D $_;
>> + =A0 =A0 =A0 =A0 =A0 =A0 $remotes->{$remote}{'heads'} =3D [ grep {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $_->{'name'} =3D~ s!^$remo=
te/!!
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } @remoteheads ];
>> + =A0 =A0 }
>> +}
>
> We could remove limiting number of heads shown per remote also from h=
ere,
> but this time 1.) the $limit parameter is passed down to git_get_head=
s_list
> which in turn uses $limit as parameter to git command =A02.) it doesn=
't
> simplify code almost at all:
>
> +sub fill_remote_heads {
> + =A0 =A0 =A0 my $remotes =3D shift;
> +
> + =A0 =A0 =A0 my @heads =3D map { "remotes/$_" } keys %$remotes;
> + =A0 =A0 =A0 ## A QUESTION: perhaps it would be better to pass @remo=
teheads as parameter?
> + =A0 =A0 =A0 my @remoteheads =3D git_get_heads_list(undef, @heads);
> + =A0 =A0 =A0 foreach my $remote (keys %$remotes) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 $remotes->{$remote}{'heads'} =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ grep { $_->{'name'} =3D=
~ s!^$remote/!! } @remoteheads ];
> + =A0 =A0 =A0 }
> +}
>
>
> A QUESTION: perhaps it would be better to pass @remoteheads as parame=
ter?
> I wonder if won't end up with calling git_get_heads_list multiple tim=
es...
> well, the improvement can be left for later. =A0Answering this questi=
on
> should not affect accepting this patch series.

I'm not sure I actually understand the question. Who should we pass
@remoteheads to?

>> +
>> =A0sub git_get_references {
>> =A0 =A0 =A0 my $type =3D shift || "";
>> =A0 =A0 =A0 my %refs;
>> @@ -5054,6 +5114,100 @@ sub git_heads_body {
>> =A0 =A0 =A0 print "</table>\n";
>> =A0}
>>
>> +# Display a single remote block
>
> Note that you would end up with two very similarly named subrotines:
> git_remote_body and git_remotes_body. =A0Perhaps it would be better t=
o
> call this one git_remote_block, or git_describe_remote?

Makes sense. I'll go with git_remote_block for similarity with git_remo=
tes_list

>> +sub git_remote_body {
>> + =A0 =A0 my ($remote, $rdata, $limit, $head) =3D @_;
>> +
>> + =A0 =A0 my $heads =3D $rdata->{'heads'};
>> + =A0 =A0 my $fetch =3D $rdata->{'fetch'};
>> + =A0 =A0 my $push =3D $rdata->{'push'};
>
> We could have used the following Perl shortcut
>
> + =A0 =A0 =A0 my ($heads, $fetch, $push) =3D @{$rdata}{qw(heads fetch=
 push)};
>
> but it isn't needed, and I guess it even could hurt readibility...

OTOH, if readibility was a priority, we wouldn't use Perl would we ;-)
Joking aside, I think I'll leave it as is, unless there's some
significant performance improvement in using the latter syntax.

>> +
>> + =A0 =A0 my $urls =3D "<table class=3D\"projects_list\">\n" ;
>> +
>> + =A0 =A0 if (defined $fetch) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ($fetch eq $push) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $urls .=3D format_repo_url=
("URL", $fetch);
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $urls .=3D format_repo_url=
("Fetch URL", $fetch);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $urls .=3D format_repo_url=
("Push URL", $push) if defined $push;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 } elsif (defined $push) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 $urls .=3D format_repo_url("Push URL", $pu=
sh);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 $urls .=3D format_repo_url("", "No remote =
URL");
>> + =A0 =A0 }
>> +
>> + =A0 =A0 $urls .=3D "</table>\n";
>
> I'm not sure about naming this variable $urls...

I'm open to suggestions. $urls_table ?

>> +
>> + =A0 =A0 my ($maxheads, $dots);
>> + =A0 =A0 if (defined $limit) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 $maxheads =3D $limit - 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ($#{$heads} > $maxheads) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $dots =3D $cgi->a({-href =3D=
> href(action=3D>"remotes", hash=3D>$remote)}, "...");
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 print $urls;
>> + =A0 =A0 git_heads_body($heads, $head, 0, $maxheads, $dots);
>
> Wouldn't this be simpler:
>
> + =A0 =A0 =A0 my $dots;
> + =A0 =A0 =A0 if (defined $limit && $limit < @$heads) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 $dots =3D $cgi->a({-href =3D> href(acti=
on=3D>"remotes", hash=3D>$remote)}, "...");
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 print $urls;
> + =A0 =A0 =A0 git_heads_body($heads, $head, 0, $limit, $dots);
>
> We would do similar trick as in other parts: request one item more th=
an we
> display to check if there is more data.

Right.

>> +}
>> +
>> +# Display a list of remote names with the respective fetch and push=
 URLs
>> +# This routine only gets called when there are more remotes than th=
e given
>> +# limit, so we know that we have to append an ellipsis to the table=
 and
>> +# that we have to pop one of the keys.
>
> I think it would be a better idea to make this subroutine generic: di=
splay
> only list of remotes, limited to $limit remotes maximum.

That's probably a good idea. I've taken some suggestions from your
proposed code, but kept the while loop.

>> + =A0 =A0 =A0 =A0 =A0 =A0 print "<td>" .
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $cgi->a({-href=3D> href(action=
=3D>'remotes', hash=3D>$remote),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-class=3D> =
"list name"},esc_html($remote)) . "</td>";
>
> Very, very minor nitpick: if "<td>" is on separate line, why "</td>"
> isn't?

Good question.

>> + =A0 =A0 print "</table>";
>> +}
>> +
>> +# Display remote heads grouped by remote, unless there are too many
>> +# remotes ($have_all is false), in which case we only display the r=
emote
>> +# names
>
> This of course also would have to be changed if limiting is done at
> display time, not at generation time (at least for limiting list of
> remotes, if not for generating list of refs).

Actually, it doesn't need to change much, since $limit was still taken
into consideration.

>> +sub git_remotes_body {
>> + =A0 =A0 my ($remotedata, $limit, $head) =3D @_;
>> + =A0 =A0 if (not defined $limit or scalar keys %$remotedata <=3D $l=
imit) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 git_get_remote_heads($remotedata, $limit);
>> + =A0 =A0 =A0 =A0 =A0 =A0 while (my ($remote, $rdata) =3D each %$rem=
otedata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git_print_section({-class=3D=
>"remote", -id=3D>$remote},
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ["remotes"=
, $remote, $remote], sub {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 git_remote_body($remote, $rdata, $limit, $head);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 });
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 git_remotes_list($remotedata, $limit);
>> + =A0 =A0 }
>
> Minor issue: wouldn't it make for easier reading to have less code in
> the 'if' part of if { ... } else { ... } clause, and more code in 'el=
se'
> part.

I was just thinking about that. It also makes the conditional more obvi=
ous.

> Perhaps it would be worth adding comment about git_remotes:
>
> @@ -5599,6 +5740,7 @@ sub git_heads {
> =A0 =A0 =A0 =A0git_footer_html();
> =A0}
>
> +# dual lived: used both for single remote view, and for list of all =
remotes

Good idea.

> Though I am not sure if it is good public API. =A0Perhaps it is...

The alternative would be to have git_remote to handle the single
remote case, and possibly even have the action name be 'remote' rather
than 'remotes' in that case.

>> - =A0 =A0 if (defined $remote) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 # only display the heads in a given remote
>> - =A0 =A0 =A0 =A0 =A0 =A0 @remotelist =3D map {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $ref =3D $_ ;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $ref->{'name'} =3D~ s!^$re=
mote/!!;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $ref
>> - =A0 =A0 =A0 =A0 =A0 =A0 } git_get_heads_list(undef, "remotes/$remo=
te");
>> - =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 @remotelist =3D git_get_heads_list(undef, =
'remotes');
>> + =A0 =A0 if (keys(%$remotedata) =3D=3D 0) {
>
> You can write simply
>
> + =A0 =A0 =A0 unless (%$remotedata) {
>
> From perldata(1): =A0"If you evaluate a hash in scalar context, it re=
turns
> false if the hash is empty."

Right.

>> - =A0 =A0 if (@remotelist) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 git_heads_body(\@remotelist, $head);
>> + =A0 =A0 =A0 =A0 =A0 =A0 git_remotes_body($remotedata, undef $head)=
;
>> =A0 =A0 =A0 }
>
> You are missing comma after 'undef' here

Subtle bug. Thanks.

--=20
Giuseppe "Oblomov" Bilotta

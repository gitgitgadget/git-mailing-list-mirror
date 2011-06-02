From: Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>
Subject: Re: [RFC/PATCH] Added a remote helper to interact with mediawiki,
 pull & clone handled
Date: Thu, 2 Jun 2011 22:28:33 +0200
Message-ID: <BANLkTi=eYg3uT1hQZO03i4MLyhRkPzXK6w@mail.gmail.com>
References: <1307006911-4326-1-git-send-email-arnaud.lacurie@ensimag.imag.fr> <20110602170327.GA2928@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?J=E9r=E9mie_Nikaes?= 
	<jeremie.nikaes@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?ISO-8859-1?Q?Sylvain_Boulm=E9?= <sylvain.boulme@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 02 22:29:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSEW1-0006zZ-26
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 22:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730Ab1FBU3F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2011 16:29:05 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55857 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424Ab1FBU2y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2011 16:28:54 -0400
Received: by vws1 with SMTP id 1so928846vws.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 13:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0AJTMNPkAWR+Ii6b/NURHMdU9oJKOjtdqbryCiS8X8Q=;
        b=Zjja/RzmNAhtYHjkcvjQagWAjZ8qfUnSOYIJUmAOkwh+99TDD5+xUy89QccXnQ4YSl
         A7aTwJ+QzF8Yiz5DYntsd3Xhd78JnX7HBzEFd4ti++M25y0lLfdiU+5poGRXwAwpXJvE
         AIB1DQm25Fb7r85s2umR2mOVJK/YEz+Jy4UUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=Sofdmr+LXHmXdexsdKb/iyQBIWs0yEtd5p4Q6ByHpsBluemwPlKnULus6H+f0p/Rji
         C3CXHw3NtQ0z4lQ9xT8SmGsOMSF4u32W6NMNjlwVzMkqM4EyvhFfA96k8ZXPMzbc1oD2
         zctGByreHpy/4GXFvosCTMPn21/CikhB5NElc=
Received: by 10.220.15.8 with SMTP id i8mr438482vca.113.1307046533136; Thu, 02
 Jun 2011 13:28:53 -0700 (PDT)
Received: by 10.220.189.8 with HTTP; Thu, 2 Jun 2011 13:28:33 -0700 (PDT)
In-Reply-To: <20110602170327.GA2928@sigill.intra.peff.net>
X-Google-Sender-Auth: kya7Jc4kbv-R-rGRfIQNt6Jt0Fs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174976>

2011/6/2 Jeff King <peff@peff.net>:
> On Thu, Jun 02, 2011 at 11:28:31AM +0200, Arnaud Lacurie wrote:
>
>> +sub mw_import {
>> [...]
>> + =A0 =A0 =A0 =A0 =A0 =A0 # Get 500 revisions at a time due to the m=
ediawiki api limit
>> + =A0 =A0 =A0 =A0 =A0 =A0 while (1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $result =3D $mediawiki-=
>api($query);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # Parse each of those 500 =
revisions
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 foreach my $revision (@{$r=
esult->{query}->{pages}->{$id}->{revisions}}) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $page_r=
ev_ids;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $page_rev_=
ids->{pageid} =3D $page->{pageid};
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $page_rev_=
ids->{revid} =3D $revision->{revid};
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 push (@rev=
isions, $page_rev_ids);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $revnum++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 last unless $result->{'que=
ry-continue'};
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $query->{rvstartid} =3D $r=
esult->{'query-continue'}->{revisions}->{rvstartid};
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "\n";
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>
> What is this newline at the end here for? With it, my import reliably
> fails with:
>
> =A0fatal: Unsupported command:
> =A0fast-import: dumping crash report to .git/fast_import_crash_6091
>
> Removing it seems to make things work.

 Yes we actually found it today. It slipped as we've never fetched
pages with more than 500 revisions since it got there...

>> + =A0 =A0 =A0 =A0 =A0 =A0 # mediawiki revision number in the git not=
e
>> + =A0 =A0 =A0 =A0 =A0 =A0 my $note_comment =3D encode_utf8("note add=
ed by git-mediawiki");
>> + =A0 =A0 =A0 =A0 =A0 =A0 my $note_comment_length =3D bytes::length(=
$note_comment);
>> + =A0 =A0 =A0 =A0 =A0 =A0 my $note_content =3D encode_utf8("mediawik=
i_revision: " . $pagerevids->{revid} . "\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 my $note_content_length =3D bytes::length(=
$note_content);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ($fetch_from =3D=3D 1 && $n =3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "reset refs/notes/co=
mmits\n";
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 print "commit refs/notes/commits\n";
>
> Should these go in refs/notes/commits? I don't think we have a "best
> practices" yet for the notes namespaces, as it is still a relatively =
new
> concept. But I always thought "refs/notes/commits" would be for the
> user's "regular" notes, and that programmatic things would get their =
own
> notes, like "refs/notes/mediawiki".
>
That's a good idea, we didn't think notes could actually not go in
refs/notes/commits. This will be perfect to distinguish the user notes
from ours.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print STDERR "You appear t=
o have cloned an empty mediawiki\n";
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #What do we have to do her=
e ? If nothing is done, an error is thrown saying that
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #HEAD is refering to unkno=
wn object 0000000000000000000
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>
> Hmm. We do allow cloning empty git repos. It might be nice for there =
to
> be some way for a remote helper to signal "everything OK, but the res=
ult
> is empty". But I think that is probably something that needs to be ad=
ded
> to the remote-helper protocol, and so is outside the scope of your
> script (maybe it is as simple as interpreting the null sha1 as "empty=
";
> I dunno).
>

Yes, that's a problem we've been running into. We didn't really know
how to solve it.

> Overall, it's looking pretty good. I like that I can resume a
> half-finished import via "git fetch". Though I do have one complaint:
> running "git fetch" fetches the metainfo for every revision of every
> page, just as it does for an initial clone. Is there something in the
> mediawiki API to say "show me revisions since N" (where N would be th=
e
> mediawiki revision of the tip of what we imported)?

I am not sure I understand your question. Because actually, we are
supporting this,
thanks to git notes. Like when you git fetch after a clone, it checks
only the last revisions

Thank you very much for your help !

Arnaud Lacurie

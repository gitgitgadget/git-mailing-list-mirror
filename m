From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 1/8] gitweb: refactor author name insertion
Date: Fri, 26 Jun 2009 01:41:28 +0200
Message-ID: <cb7bb73a0906251641g71250105ob608b557cce7c454@mail.gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906260055.11347.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 01:41:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJyZV-0002zW-OW
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 01:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbZFYXl2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2009 19:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbZFYXl1
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 19:41:27 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:58048 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbZFYXl1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2009 19:41:27 -0400
Received: by fxm9 with SMTP id 9so1795402fxm.37
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 16:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DGT1iAsBsreMqBYyJE1GefZmrJVaJdIIdQ+/69QH+8I=;
        b=V2ldjOrYwE4AjFFXhM0F+NFHivuTKcn5hlKKKFZQ9BTdhubFIj3gHdlDAjvo8PdrYF
         0GxFlcrB29AyJS7ycXxSt1bXssbfoKncXWRYLYJN8+aeZkUlts6OaIb542cjJjxrGTeb
         A5WX5P6m2iwJT2n8isS3nAzR13G8NQlekmxUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k2p5LXBRYC/SzlDgCbJIUtU+/lXYG2VYuRhrsgyBUUTMg3c8Cz6qFXgDFa5jMVh6Qm
         EzQH0vc5xNE9ahBephQrsJ+N+PV6Auib/QaKUrOsYLQ+gsnTIRDOHLj8bVZ97bwUogaF
         RE+gs1CEiQ3QySamdiGjhNpWF4W9iAeklQHUM=
Received: by 10.204.66.69 with SMTP id m5mr2890408bki.174.1245973288629; Thu, 
	25 Jun 2009 16:41:28 -0700 (PDT)
In-Reply-To: <200906260055.11347.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122261>

2009/6/26 Jakub Narebski <jnareb@gmail.com>:
> Do I understand it correctly that this was meant as pure refactoring,
> i.e. that none of gitweb output should have changed? =A0Because you m=
ade
> a mistake, and 'log' view is broken (and it doesn't look like it did
> before). =A0See comments below for cause and (simple) solution.

Thanks for noticing. And yes, the problem is indeed that I forgot to
specify tag =3D> span in git log view (I'm keeping div the default
because that's what was there in the first place in
git_print_authorship).

>> +# format the author name of the given commit with the given tag
>> +# the author name is chopped and escaped according to the other
>> +# optional parameters (see chop_str).
>> +sub format_author_html {
>> + =A0 =A0 my $tag =3D shift;
>> + =A0 =A0 my $co =3D shift;
>> + =A0 =A0 my $author =3D chop_and_escape_str($co->{'author_name'}, @=
_);
>> + =A0 =A0 return "<$tag class=3D\"author\">" . $author . "</$tag>\n"=
;
>> +}
>
> Good... although I wonder if we should not get rid of chop_and_escape=
_str
> altogether, and for example add title attribute (if needed due to hav=
ing
> to do shortening) directly to $tag, and not to inner <span> element.

This would require some additional refactoring, and I don't have a
clear idea on how to best implement it right now. I'm afraid it'll
have to wait for another time.

> Should "\n" be in returned string? Just asking.

You're right, we probably don't want to force the newline there. The
real question is, do we want the callers to put a newline there? I'm
thinking no, because it's mostly used in table cells and a newline is
better done at the row level, but I'm not sure either way. I'll just
remove it for the time being, it should only have effects at the
sourcecode level, not on the layout.

> Usually though we use %opts and not %params for the name of this
> hash, and we use CGI-like keys prefixed by '-', for example
> '-z' in parse_ls_tree_line(), '-nbsp' in esc_html, '-nohtml' in
> quot_cec(), =A0'-remove_title', '-remove_signoff' and '-final_empty_l=
ine'
> in git_print_log(). =A0git_commitdiff() uses %params, but it doesn't
> have non-optional parameters (still, I guess we should use %opts
> for consistency), and it uses '-format' and '-single' as names.
>
> href() subroutine uses %params... but those are not extra named
> optional parameters to subroutine; they are CGI query parameters.

I'll adjust the code accordingly. BTW the %params in git_commitdiff is
my fault too, IIRC.

>> =A0 =A0 =A0 my %ad =3D parse_date($co->{'author_epoch'}, $co->{'auth=
or_tz'});
>> - =A0 =A0 print "<div class=3D\"author_date\">" .
>> + =A0 =A0 print "<$tag class=3D\"author_date\">" .
>> =A0 =A0 =A0 =A0 =A0 =A0 esc_html($co->{'author_name'}) .
>> =A0 =A0 =A0 =A0 =A0 =A0 " [$ad{'rfc2822'}";
>> + =A0 =A0 if ($params{'localtime'}) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ($ad{'hour_local'} < 6) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf(" (<span class=3D\"=
atnight\">%02d:%02d</span> %s)",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$ad{'hour_l=
ocal'}, $ad{'minute_local'}, $ad{'tz_local'});
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf(" (%02d:%02d %s)",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$ad{'hour_l=
ocal'}, $ad{'minute_local'}, $ad{'tz_local'});
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> + =A0 =A0 print "]</$tag>\n";
>> +}
>
> Gaah, git has chosen to show this diff a bit strangely...

Oh, very funny indeed. I hadn't realized it went that way. Wonder if
the patience diff would have helped here.

> By the way, what about author / tagger info used in 'tag' view?

I totally forgot about that.

> Wouldn't it be better to factor out generating table rows for single
> author / committer / tagger header (field) info?

Good idea. I'm not sure the tagger field has all the relevant data. I'l=
l check.

> I'd rather use here (as mentioned in comment about git_print_full_aut=
horship
> subroutine) something like the following:
>
> + =A0 =A0 =A0 git_print_authorship_header(\%co, 'author');
> + =A0 =A0 =A0 git_print_authorship_header(\%co, 'committer');
>
> Or something like that. =A0But this might be a matter of taste.

I renamed the sub to git_print_authorship_rows, and I'm making it
accept a list of people to print info for. I'll make it default to
both author and committer though.


--=20
Giuseppe "Oblomov" Bilotta

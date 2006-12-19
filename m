X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Show '...' links in "summary" view only if there are more items
Date: Tue, 19 Dec 2006 13:28:08 +0100
Message-ID: <200612191328.08928.jnareb@gmail.com>
References: <20061218224327.GG16029@localhost> <200612191214.58474.jnareb@gmail.com> <20061219120854.GA16429@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 19 Dec 2006 12:25:57 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Atl+dEhWFzRY6xuqPEJLOJTmwv9jet+6zKgu/pM5fcr7HhJ/N3XykvqyG/2L6vE1MtlTz14wdPAGxJQ9Of3Cl1ATq0n6vnZxKQb4q/QUPpU/NcS24xQXd4Qj9cFbtyiOaPMsreUTYEXYZ6ETVqT3yKEeEiPF/CQ+o6ZwBVoBwmc=
User-Agent: KMail/1.9.3
In-Reply-To: <20061219120854.GA16429@localhost>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34827>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gwe2N-0000LF-Hr for gcvg-git@gmane.org; Tue, 19 Dec
 2006 13:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932805AbWLSMZg convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006 07:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932808AbWLSMZg
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 07:25:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:11853 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932805AbWLSMZf (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec
 2006 07:25:35 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1802555uga for
 <git@vger.kernel.org>; Tue, 19 Dec 2006 04:25:34 -0800 (PST)
Received: by 10.66.221.6 with SMTP id t6mr6989089ugg.1166531134208; Tue, 19
 Dec 2006 04:25:34 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id m1sm10857326uge.2006.12.19.04.25.33; Tue, 19 Dec
 2006 04:25:33 -0800 (PST)
To: Robert Fitzsimons <robfitz@273k.net>
Sender: git-owner@vger.kernel.org

Robert Fitzsimons wrote:
> Show "..." links in "summary" view to shortlog, heads (if there are
> any), and tags (if there are any) only if there are more items to sho=
w
> than shown already.
>=20
> This means that "..." link is shown below shortened shortlog if there
> are more than 16 commits, "..." link below shortened heads list if
> there are more than 16 heads refs (16 branches), "..." link below
> shortened tags list if there are more than 16 tags.
>=20
> Modified patch from Jakub to to apply cleanly to master, also preform
> the same "..." link logic to the forks list.

Junio usually puts such comments in brackets (I don't know if it is
always used, i.e. if it is some 'convention'), e.g.:

  Also perform the same "..." link logic to the forks list.

  [rf: Modified patch from Jakub to to apply cleanly to master]

or something like that. Just a nitpick.


By the way, it looks like git_get_projects_list($project) used to get
list of forks does not have any count limit option.

[...]
> ---
>
> > By the way, I have _NOT_ applied Robert Fitzsimons patch, but they
> > (this patch and Robert patch) should be not in conflict if we
> > remove last chunk of Robert's patch (this changing --count=3D17 to
> > --count=3D15 in git_summary).
>
> Just removing the last chunk isn't correct, there are two slightly
> different changes in that chuck. =A0The reduction in the max-count
> value and a removal of a call to git_get_head_hash.

The last chunk I meant to be removed was:

> @@ -2876,8 +2879,8 @@ sub git_summary {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> =A0=A0=A0=A0=A0=A0=A0=A0}
> =A0
> -=A0=A0=A0=A0=A0=A0=A0open my $fd, "-|", git_cmd(), "rev-list", "--ma=
x-count=3D17",
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0git_get_head_hash($proj=
ect), "--"
> +=A0=A0=A0=A0=A0=A0=A0open my $fd, "-|", git_cmd(), "rev-list", "--ma=
x-count=3D16",
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0$head, "--"
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0or die_error(undef, "=
Open git-rev-list failed");
> =A0=A0=A0=A0=A0=A0=A0=A0my @revlist =3D map { chomp; $_ } <$fd>;
> =A0=A0=A0=A0=A0=A0=A0=A0close $fd;

and if we remove that chunk, then your earlier patch would not
touch git_summary at all, so mine would cleanly apply (I think).

[...]
> -	my @taglist  =3D git_get_tags_list(15);
> -	my @headlist =3D git_get_heads_list(15);
> +	# we need to request one more than 16 (0..15) to check if those 16 =
are all
> +	my @taglist  =3D git_get_tags_list(16);
> +	my @headlist =3D git_get_heads_list(16);

It needs to be 17, not 16, otherwise we never would get "...". By defau=
lt
we show _16_ items, from 0 to 15 inclusive, so we must get _17_ items
to check if there are more than 16.

>  	my @forklist;
>  	my ($check_forks) =3D gitweb_check_feature('forks');
> =20
> @@ -2955,30 +2956,35 @@ sub git_summary {
>  		}
>  	}
> =20
> -	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=3D16",
> +	# we need to request one more than 16 (0..15) to check if those 16 =
are all
> +	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=3D17",

Here you have 17.


>  	if (@forklist) {
>  		git_print_header_div('forks');
>  		git_project_list_body(\@forklist, undef, 0, 15,
> +		                      $#forklist <=3D 15 ? undef :
>  		                      $cgi->a({-href =3D> href(action=3D>"forks")}=
, "..."),
>  				      'noheader');
>  	}

Nice catch. I forgot about this one.

--=20
Jakub Narebski

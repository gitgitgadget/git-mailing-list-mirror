From: Ben Boeckel <mathstuf@gmail.com>
Subject: Re: [PATCH v2] remote: add get-url subcommand
Date: Mon, 3 Aug 2015 20:16:31 -0400
Message-ID: <20150804001631.GA10416@megas.kitware.com>
References: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
 <1438635614-11174-1-git-send-email-mathstuf@gmail.com>
 <1438635614-11174-2-git-send-email-mathstuf@gmail.com>
 <CAPig+cQO_jXZmJG=EccwQ408TiAk7_BiQF1UKA31phXF7CXy6w@mail.gmail.com>
Reply-To: mathstuf@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 02:16:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMPuU-0002SU-J2
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 02:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934AbbHDAQh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Aug 2015 20:16:37 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36285 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755923AbbHDAQe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 20:16:34 -0400
Received: by igbij6 with SMTP id ij6so64631411igb.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 17:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MCctHelFEzGleqObooTKF4tCqn/bScMfrz5orfndGts=;
        b=pZF6F6LeALuKWkuHbbXOgNvkbDXki0aSoJm72956laSl8QZeWLi6xytywq1NQ2MvJt
         qIyb6jvYBMWBeAgIVXn/xyLxYr0kE5IiSl0WvTA24r1yHpT79frCyMHVL3VpOcIurq4B
         Vmh+Xq7uAYavxaobpuz1ANztrdF9k1msQJroqjD/fXVO/xbocnY+ka/1y9Vi3Rr6YNKa
         8HMMMZSB0Igb3R7ztTJbT56NisxmXPd7Nbzes/CAPsg486gJK4LPSOYQkcfZnukubDba
         Vs5FGjefT21qpwq5dvdwFPJzD1A2Z0vbhfYQTc32WIN1lavRTUQyeLzr2LlL7ownXwLr
         8cpg==
X-Received: by 10.50.65.74 with SMTP id v10mr724336igs.97.1438647394104;
        Mon, 03 Aug 2015 17:16:34 -0700 (PDT)
Received: from megas (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id rq1sm82659igb.21.2015.08.03.17.16.32
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 17:16:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cQO_jXZmJG=EccwQ408TiAk7_BiQF1UKA31phXF7CXy6w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275232>

On Mon, Aug 03, 2015 at 19:38:15 -0400, Eric Sunshine wrote:
> On Mon, Aug 3, 2015 at 5:00 PM, Ben Boeckel <mathstuf@gmail.com> wrot=
e:
> > +               OPT_BOOL('\0', "push", &push_mode,
> > +                        N_("query push URLs")),
>=20
> A bit more explanatory:
>=20
>     "query push URLs rather than fetch URLs"

=46ixed.

> > +               OPT_BOOL('\0', "all", &all_mode,
> > +                        N_("return all URLs")),
> > +               OPT_END()
> > +       };
> > +       argc =3D parse_options(argc, argv, NULL, options, builtin_r=
emote_geturl_usage,
> > +                            PARSE_OPT_KEEP_ARGV0);
>=20
> What is the reason for PARSE_OPT_KEEP_ARGV0 in this case?

Copied from get-url; I presume for more natural argv[] usage within the
function.

> > +       if (argc < 1 || argc > 2)
> > +               usage_with_options(builtin_remote_geturl_usage, opt=
ions);
>=20
> So,  'argc' must be 1 or 2, which in 'argv' terms is argv[0] and argv=
[1]).

=E2=80=A6

> > +       remotename =3D argv[1];
>=20
> But here, argv[1] is accessed unconditionally, even though 'argc' may
> have been 1, thus out of bounds.

Yep, should be (argc < 2 || argc > 2) (or 1 if PARSE_OPT_KEEP_ARGV0 is
removed). Off-by-one when converting from get-url.

I'll reroll tomorrow morning in case there are more comments until then
(particularly about PARSE_OPT_KEEP_ARGV0).

Thanks,

--Ben

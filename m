Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD211845
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 01:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvtRQEyp"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55679552710so2842a12.1
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 17:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704417147; x=1705021947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lzJh/UyWyKzeYppavfAmy+S0tDLSRUye6zVxW7eiCA=;
        b=FvtRQEyp/hR52FG+9IbUBgjt9mUc9dZZhj6+NlSTSXkS5jC4j45Q0cJ4yQLJx4G78r
         KKFW04x3aYoYvafc6T4mfNJ+zLmFG0gJ9FfockSGqJKSveEBeeiNw/ozRIbCk3E78icM
         0OWD7dX3MPK/YTUmtoCgBxM//e61/Rmja1tsfOrwca8b2iX+cTrYVPaE4D87I4V+Gbgd
         PVz3gba43VYArorB2TUIw7D9pfzpfp12+uq57oi32jbrvEBdw97G+38/IZzSqIcuJKtP
         D6YP1xBcvPbFxo/AUkcFEmXWwWshb021bfIiTy7fuHGkIwO8KurZmOa16RaehZLjQpr3
         pFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704417147; x=1705021947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lzJh/UyWyKzeYppavfAmy+S0tDLSRUye6zVxW7eiCA=;
        b=eUbTN0xuTzyz6LKDrUlrThu0maIzzDVwe+3OTK+6z7B81VUQtIMdHB3tML/fhF8Cwh
         q7HvNnKLd3FheUnMgDgorYhtsO2w7OBjQ/4SHzQUCaA/0cPLvrpRHP94/dnCZHluDt3I
         yXwhv2GsBadnqcgMlHo/jDGCxoRnvd54qfW3DMhUo5cyoKtA9M1G6+f1ZJeXgboSQ3f8
         B1gZugrQCU/7/tDi36sdB+jlJ7Zswh9ojfa+0gbxEpn9MWVRCbEoh5C1zsxeHZwn4016
         OIE0N5xFP/bl9/n/+IHTKU71oGmNrJVsptJb+R/Tu54l/VcD1jxHvacep3MELGoJsIDX
         0C1w==
X-Gm-Message-State: AOJu0YxsRI8aEy3QyQIGqY7nfQNVzJSymobdC0qzzxOeQ17u8p5Vc9AV
	SiFzJ+qiZ7CTwqGDtZtLTyhSLpIO8gbQ3wCgYE+8GIX5upy1
X-Google-Smtp-Source: AGHT+IExyTC2d8jpwtne6qIDv8gpPRnim2msjC2yEa3Lv7wJEbiaJS4pxIajiwNs63KxHlVu9U1MRG8FIc6ew0ifxRw=
X-Received: by 2002:a50:8743:0:b0:553:5578:2fc9 with SMTP id
 3-20020a508743000000b0055355782fc9mr42374edv.5.1704417147438; Thu, 04 Jan
 2024 17:12:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103224054.1940209-1-delmerico@google.com> <xmqqbka27zu9.fsf@gitster.g>
In-Reply-To: <xmqqbka27zu9.fsf@gitster.g>
From: Sam Delmerico <delmerico@google.com>
Date: Thu, 4 Jan 2024 17:12:15 -0800
Message-ID: <CAHVcGPSSJr7L_NyFSKEkEywBap6hUrucga98RLpa6xuZ0k4CzA@mail.gmail.com>
Subject: Re: [PATCH] push: region_leave trace for negotiate_using_fetch
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

* I don't exactly remember how I noticed it. I was doing some
debugging around the push negotiation code and either 1) saw this
region get entered twice in the trace output, or 2) I was just reading
the code around here and saw two enters.

* Perhaps there could be a check before the last git process ends that
checks that all opened trace regions have been closed? I'm not sure
how much work this would involve. It's probably also not a very
proactive way to catch these bugs since it would only get triggered
when a *user* hits a code path with a trace region that never exits.

* There could also be a test that checks that every region_enter trace
log has a corresponding region_leave. But I'm not sure how to ensure
that every code path is checked.

Overall, I'm not sure how much benefit there is from checking for
this. I'm not sure that it would have a large impact if it were to
happen again. For example, I think that it could be noticed relatively
quickly by a person/system looking at metrics like I was (e.g. if the
time spent in a region is infinite or zero).

FWIW I didn't see any other examples of this when going through logs.

Sam
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed=
,
Jan 3, 2024 at 3:37=E2=80=AFPM Junio C Hamano &lt;gitster@pobox.com&gt;
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0px 0px
0px 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left:
1ex;">Sam Delmerico &lt;<a href=3D"mailto:delmerico@google.com"
target=3D"_blank">delmerico@google.com</a>&gt; writes:<br>
<br>
&gt; There were two region_enter events for negotiate_using_fetch instead o=
f<br>
&gt; one enter and one leave. This commit replaces the second region_enter<=
br>
&gt; event with a region_leave.<br>
&gt;<br>
&gt; Signed-off-by: Sam Delmerico &lt;<a
href=3D"mailto:delmerico@google.com"
target=3D"_blank">delmerico@google.com</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; fetch-pack.c | 2 +-<br>
&gt;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
Looks right, after skimming a29263cf (fetch-pack: add tracing for<br>
negotiation rounds, 2022-08-02).&nbsp; Two questions and a half.<br>
<br>
&nbsp;* How did you find it?&nbsp; Code inspection?&nbsp; While
writing a script to<br>
&nbsp; &nbsp;parse the output from around this area, your script noticed th=
e<br>
&nbsp; &nbsp;ever-increasing nesting level?&nbsp; Something else?<br>
<br>
&nbsp;* Would it be feasible to write some tests or tools that find<br>
&nbsp; &nbsp;similar problems (semi-)automatically?<br>
<br>
&nbsp;* Is the breakage (before this patch) something easily demonstrated<b=
r>
&nbsp; &nbsp;in a new test in t/ somewhere?&nbsp; And if so, would it
be worth<br>
&nbsp; &nbsp;doing?<br>
<br>
Thanks.&nbsp; Will queue.<br>
<br>
<br>
&gt;<br>
&gt; diff --git a/fetch-pack.c b/fetch-pack.c<br>
&gt; index 31a72d43de..dba6d79944 100644<br>
&gt; --- a/fetch-pack.c<br>
&gt; +++ b/fetch-pack.c<br>
&gt; @@ -2218,7 +2218,7 @@ void negotiate_using_fetch(const struct
oid_array *negotiation_tips,<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; the_repository, "%d",<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; negotiation_round);<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; -&nbsp; &nbsp; &nbsp;trace2_region_enter("fetch-pa<wbr>ck",
"negotiate_using_fetch", the_repository);<br>
&gt; +&nbsp; &nbsp; &nbsp;trace2_region_leave("fetch-pa<wbr>ck",
"negotiate_using_fetch", the_repository);<br>
&gt;&nbsp; &nbsp; &nbsp;
&nbsp;trace2_data_intmax("<wbr>negotiate_using_fetch",
the_repository,<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; "total_rounds", negotiation_round);<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp;clear_common_flag(acked_commi<wbr>ts);<br>
&gt;<br>
&gt; base-commit: a26002b62827b89a19b1084bd75d93<wbr>71d565d03c<br>
</blockquote></div>

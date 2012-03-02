From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v7 01/10] Add git-column for columnar display
Date: Fri, 2 Mar 2012 19:36:30 +0700
Message-ID: <CACsJy8BQy_j08x5k_bzcngTy4qKi9DPkKCDA1hEUR6-osRTf2g@mail.gmail.com>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com> <1330430331-19945-2-git-send-email-pclouds@gmail.com>
 <7v8vjm25iy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 13:37:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3RjS-0000t5-8i
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 13:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106Ab2CBMhD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Mar 2012 07:37:03 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:49995 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964908Ab2CBMhC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 07:37:02 -0500
Received: by wejx9 with SMTP id x9so1005188wej.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 04:37:00 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.74.177 as permitted sender) client-ip=10.180.74.177;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.74.177 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.74.177])
        by 10.180.74.177 with SMTP id u17mr4933912wiv.13.1330691820714 (num_hops = 1);
        Fri, 02 Mar 2012 04:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=aj5cWD+iqPA/uuu9Ez1Aoc1lHW/eRgvjhmMizwbqIUU=;
        b=JPUEXVqUuYJpDLEIG1YFjoszOrAUK0mlq1h3QLEXLbFUvT6pN3OojIBOdvFcb+/e4l
         JLD6bZXPRSyuOl320IMJEBoh38S5Ztcid11kAdmuYSSW3Q/qrmtH1+JOVwPEpIxHfCgM
         awaFUAg5rq/4moDhE2IVBk8H9CShZertkpxjxb+jsnKEtFOc3/BhcKRQX9utp9UJlAtZ
         WZIKP1bsXmaiBOEUylFPQ/9deRzpp6d3Dnk9E/0N6xYBVI3L98irHYSbTy8ennpzR7hU
         wyEzVhNNuBfYg1D4iE3Uc/F3fh+YxYgFjTfN22njJz95gZsuK57xPx7zS3ztkSzHX0A+
         nwzg==
Received: by 10.180.74.177 with SMTP id u17mr3958521wiv.13.1330691820548; Fri,
 02 Mar 2012 04:37:00 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Fri, 2 Mar 2012 04:36:30 -0800 (PST)
In-Reply-To: <7v8vjm25iy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192033>

2012/2/29 Junio C Hamano <gitster@pobox.com>:
>> + =C2=A0 =C2=A0 memset(&copts, 0, sizeof(copts));
>> + =C2=A0 =C2=A0 copts.width =3D term_columns();
>> + =C2=A0 =C2=A0 copts.padding =3D 1;
>> + =C2=A0 =C2=A0 argc =3D parse_options(argc, argv, "", options, buil=
tin_column_usage, 0);
>
> Curious. The usual pattern is to set up the built-in default, call
> git_config() to override it with the configured values, and then call
> parse_options() to override at the runtime. =C2=A0I see configuration=
 callback
> defined in column.c but no call to git_config() here?

History reason. It was test-column and I did not care much whether it
respected config. Will fix.

>> +void print_columns(const struct string_list *list, unsigned int mod=
e,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct colu=
mn_options *opts)
>> +{
>> + =C2=A0 =C2=A0 const char *indent =3D "", *nl =3D "\n";
>> + =C2=A0 =C2=A0 int padding =3D 1, width =3D term_columns();
>> +
>> + =C2=A0 =C2=A0 if (!list->nr)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 if (opts) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (opts->indent)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 indent =3D opts->indent;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (opts->nl)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 nl =3D opts->nl;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (opts->width)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 width =3D opts->width;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 padding =3D opts->paddin=
g;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 if (width <=3D 1 || !(mode & COL_ENABLED)) {
>
> Curious why this is "1". =C2=A0If your terminal is only 2 columns wid=
e, you
> wouldn't be able to show your list items in two columns as you would =
want
> to have an inter-column gap, no?

Yeah, should drop that "width <=3D 1". Other layout functions should be
able to deal with too narrow width anyway.


>> + =C2=A0 =C2=A0 if (set < 0) { =C2=A0/* auto */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (stdout_is_tty < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 stdout_is_tty =3D isatty(1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set =3D stdout_is_tty ||=
 (pager_in_use() && pager_use_color);
>
> Why does this have anything to do with the use of color?

Hm.. no it does not have to.

>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 if (set)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *mode =3D *mode | COL_EN=
ABLED | COL_ENABLED_SET;
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *mode =3D (*mode & ~COL_=
ENABLED) | COL_ENABLED_SET;
>> + =C2=A0 =C2=A0 return 0;
>> +}
>
> OK, so we record the desired value (either COL_ENABLED or not) and th=
e
> fact that a call to set_enable_bit() function set it. =C2=A0Which imp=
lies that
> this function must be called from only one codepath (either setting f=
rom
> the configuration mechanism, or by parsing the command line option) b=
ut
> not both. =C2=A0I guess this is only called from configuration codepa=
th?

Both share the same code path. COL_ENABLED_SET is probably badly
named, perhaps COL_ENABLED_VALID is better. It's there to deal
distinguish "never" and not explicitly stating any of
never/auto/always. In both cases, COL_ENABLED is 0. COL_ENABLED_SET is
set in the former, but not in the latter. I depend on that to make
default behavior "always". Now thinking again, it would make more
sense to set default "never", and drop COL_ENABLED_SET.

> I am afraid that we do not have enough to judge if this is sane in th=
is
> patch, as there is no support for column.ui at this stage. =C2=A0Perh=
aps the
> series is not structured well and has things that are not yet relevan=
t in
> early part of it. =C2=A0Sigh.

If it's not clear whether it's sane, it's more likely not. I'll
re-read the series again and redo. One good thing about git
development is only tidy things can become part of upstream, which
makes archaelogy a pleasant experience.
--=20
Duy

From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v7 5/6] fast-import: add option command
Date: Sat, 12 Sep 2009 21:40:00 +0200
Message-ID: <fabb9a1e0909121240q67dbcd11ube72dcbbd276168e@mail.gmail.com>
References: <1252247748-14507-1-git-send-email-srabbelier@gmail.com> 
	<1252247748-14507-2-git-send-email-srabbelier@gmail.com> <1252247748-14507-3-git-send-email-srabbelier@gmail.com> 
	<1252247748-14507-4-git-send-email-srabbelier@gmail.com> <1252247748-14507-5-git-send-email-srabbelier@gmail.com> 
	<1252247748-14507-6-git-send-email-srabbelier@gmail.com> <20090912190416.GS1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.clatworthy@canonical.com>,
	Matt McClure <mlm@aya.yale.edu>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	vcs-fast-import-devs@lists.launchpad.net
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 12 21:40:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmYST-0007uN-Mn
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 21:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831AbZILTkU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2009 15:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754783AbZILTkT
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 15:40:19 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:34993 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767AbZILTkR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 15:40:17 -0400
Received: by ey-out-2122.google.com with SMTP id 25so398848eya.19
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 12:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0ijI/0CfBDz+rZTVZtoEcGH5rI9ojvahxD/jMb7OdUk=;
        b=bTUDep62SCJhO1fMi2xgFYW+JPMU8qY97Q1EnC6ZjQvP4tCBhhvBthAi3KL2jy5Bi+
         TwcAev8BZ8yK2+DEaRGPta/7ghIX0vmoyqtWcc9vQTjD0jPQ2GXhm3cqCt7BF0zBulZA
         +DRyZyBt30ORTAAUp1UIEP47EsOGKaI9mzhVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uBqpy8y89G9qDBLXCGb93JLWN0z0DwQ5lznji3YyHEAvHHlOY0jfqFqc0TA0qcm+lB
         4wkd/oEohx7FPA4yFiUCzZxIwvdQAdAYRFFf0nrLR6eufY47zCHzOaU1Pd1TPtWNvO7P
         fnteTObNa1Qq1C+WfqXuiJkUnjocTwnGg7WOE=
Received: by 10.216.73.193 with SMTP id v43mr1108329wed.157.1252784420134; 
	Sat, 12 Sep 2009 12:40:20 -0700 (PDT)
In-Reply-To: <20090912190416.GS1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128290>

Heya,

On Sat, Sep 12, 2009 at 21:04, Shawn O. Pearce <spearce@spearce.org> wr=
ote:
> The more I think about this, I may have to agree with Ian, I'm not
> sure option makes much sense.

Perhaps instead we can replace the option series with a few extra
features? That is 'feature git-quiet' (or maybe just 'feature quiet')
and 'feature git-marks' (or just 'feature marks', since its' fairly
generic)?

> But what should happen if "option import-marks=3Dbleh" isn't
> understood by fast-import? =A0Wouldn't the stream be useless anyway,
> because the marks it assumes aren't present? =A0Or worse, "option
> export-marks=3Dbleh" isn't recognized. =A0The stream imports, but any
> marks it was supposed to store for the frontend to reuse later
> are gone.

This was why originally we aborted when we see an unrecognized option,
I agree that due to how the series has evolved this is not such a good
idea anymore.

> @@ -2485,6 +2518,27 @@ static int git_pack_config(const char *k, cons=
t char *v, void *cb)
>> =A0static const char fast_import_usage[] =3D
>> =A0"git fast-import [--date-format=3Df] [--max-pack-size=3Dn] [--dep=
th=3Dn] [--active-branches=3Dn] [--export-marks=3Dmarks.file]";
>>
>> +static void parse_argv(void)
>> +{
>> + =A0 =A0 unsigned int i;
>> +
>> + =A0 =A0 for (i =3D 1; i < global_argc; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 const char *a =3D global_argv[i];
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (*a !=3D '-' || !strcmp(a, "--"))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* error on unknown options */
>> + =A0 =A0 =A0 =A0 =A0 =A0 parse_one_option(a + 2, 0);
>> + =A0 =A0 }
>> + =A0 =A0 if (i !=3D global_argc)
>> + =A0 =A0 =A0 =A0 =A0 =A0 usage(fast_import_usage);
>> +
>> + =A0 =A0 seen_non_option_command =3D 1;
>
> So if I pass a single command line option, like --export-marks,
> we die if we see an "option git " inside of the stream? =A0That's not
> what we wanted to do.

Nope, parse_argv isn't called until after we encounter a non-git
option. I think there's a test that makes sure this works too.

> I thought on fast-import list we agreed that the syntax of option was=
:

Right.

> So what is this parse_nongit_option() for, other than to obfuscate
> the code? =A0Can't we handle all of this in parse_option, have it
> check the VCS tag, and return early there?

I wanted to make it obvious that we ignore non-git options; depending
on whether we want to keep the option part of this series in the first
place I'll either handle it all in parse_option or drop those patches.

--=20
Cheers,

Sverre Rabbelier

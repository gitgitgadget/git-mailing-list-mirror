From: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
Subject: Re: [PATCH] Fix argument handling for fetch-pack call when stdout is connected and -q/--quiet is supplied.
Date: Sat, 4 Oct 2008 00:33:35 +0400
Message-ID: <85647ef50810031333m254036bav81d6dd4a58fb56da@mail.gmail.com>
References: <4ac8254d0810031234x26ebc96cy7cf5dcae2ef516e0@mail.gmail.com>
	 <alpine.LNX.1.00.0810031548260.19665@iabervon.org>
	 <4ac8254d0810031318j3e0f326ewc4bf250c51681670@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org,
	davej@codemonkey.org.uk
To: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 22:34:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlrMP-0005P7-6t
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 22:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbYJCUdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 16:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753033AbYJCUdi
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 16:33:38 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:9221 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980AbYJCUdh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 16:33:37 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1206939fkq.5
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 13:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kUxBxb7K+U9hZx7DK67RTC9EzDqQ5VhpyJ6qel1Ux/Y=;
        b=EmFGDjYWLw8xk3bG4Bd4uuplFT9etbTUiUtBssVkAtL4ied5v/ESS6x4+1QBfHsYCR
         iypvRnLJZwxdCaEiTICLVd9KhomtEyojwlfOiOFcGQqdxTpoVi/hcdT6FdiKBAniqu0F
         RbLhmYw8ioUVaM8wnQIiTeCoKaARFBhGKGInc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=DCNsA+I6gxhWRO62UQg7Ffe8MMojvSufpszU/MoVA8dQwi1J6uX+/4TFA8GAy/sAaK
         GbYtzG+GCbO00mkw6fj+ynb4DXrQkVS9eN3EBZaKy/MAYH4ij6o1Z+K0obpT+OwXufQA
         g7Ny2EZD1tuC6whyRgTdV5AOPB7vUehw0KNLM=
Received: by 10.181.5.4 with SMTP id h4mr1302511bki.37.1223066015705;
        Fri, 03 Oct 2008 13:33:35 -0700 (PDT)
Received: by 10.180.230.10 with HTTP; Fri, 3 Oct 2008 13:33:35 -0700 (PDT)
In-Reply-To: <4ac8254d0810031318j3e0f326ewc4bf250c51681670@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97452>

I think such patch would be too harsh for IDE plugin developers. When
git is run from IDE, the isatty(1) will be true. But progress
information will be still useful, to display an operation progress to
user. Please provide a way to force output of progress (for example
using environment).

Regards,
Constantine


On Sat, Oct 4, 2008 at 12:18 AM, Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
> On Fri, Oct 3, 2008 at 9:50 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
>> On Fri, 3 Oct 2008, Tuncer Ayaz wrote:
>
> <snip>
>
>>> diff --git a/transport.c b/transport.c
>>> index 71433d9..1f24011 100644
>>> --- a/transport.c
>>> +++ b/transport.c
>>> @@ -644,7 +644,7 @@ static int fetch_refs_via_pack(struct transport *transport,
>>>     args.include_tag = data->followtags;
>>>     args.verbose = (transport->verbose > 0);
>>>     args.quiet = args.no_progress = (transport->verbose < 0);
>>> -   args.no_progress = !isatty(1);
>>> +   args.no_progress = args.quiet || !isatty(1);
>>
>> If you're doing that, remove the "args.no_progress =" from the previous
>> line, which was there to have that effect (but not so clearly). Aside from
>> that, it looks good to me.
>>
>
> <snip>
>
> Thanks Daniel, that makes a lot of sense.
>
> Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
> ---
>  transport.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/transport.c b/transport.c
> index 71433d9..35cac44 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -643,8 +643,8 @@ static int fetch_refs_via_pack(struct transport *transport,
>        args.use_thin_pack = data->thin;
>        args.include_tag = data->followtags;
>        args.verbose = (transport->verbose > 0);
> -       args.quiet = args.no_progress = (transport->verbose < 0);
> -       args.no_progress = !isatty(1);
> +       args.quiet = (transport->verbose < 0);
> +       args.no_progress = args.quiet || !isatty(1);
>        args.depth = data->depth;
>
>        for (i = 0; i < nr_heads; i++)
> --
> 1.6.0.2
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

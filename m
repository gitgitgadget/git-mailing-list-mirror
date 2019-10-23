Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CC901F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 15:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406491AbfJWPIV (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 11:08:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47824 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406489AbfJWPIV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 11:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571843299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CFdobIz9JuWkTgLveENmheErlUXkzjZ9KQ5auvs1JHY=;
        b=HRkYyDWJmV9szc9w+GidDjHT3hTkuXcylnLWMJiI+WGZrpNYlMO8fjCufhqebXgWUfSFE5
        xrQG6w0HBh1VN2+TI3tPZG2UpHq9ulH1d/r/vfIui0C2oEbEtLgGcbV8BYG9WB6w2qa7tZ
        WVcvwhFlDdOXUXzY40YhTAQafgSBp6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-ZXclIpb5O_arUX6XXPpHew-1; Wed, 23 Oct 2019 11:08:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30245107AD34;
        Wed, 23 Oct 2019 15:08:15 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D58D019C77;
        Wed, 23 Oct 2019 15:08:14 +0000 (UTC)
Subject: Re: [PATCH] pretty: Add "%aU"|"%au" option to output author's
 username
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20191022232847.5212-1-prarit@redhat.com>
 <20191022234822.f4ixqcpfytimiscn@camp.crustytoothpaste.net>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <83b6ad72-9077-a4ce-09b7-84ce6aabf84f@redhat.com>
Date:   Wed, 23 Oct 2019 11:08:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191022234822.f4ixqcpfytimiscn@camp.crustytoothpaste.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ZXclIpb5O_arUX6XXPpHew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/22/19 7:48 PM, brian m. carlson wrote:
> On 2019-10-22 at 23:28:47, Prarit Bhargava wrote:
>> In many projects the number of contributors is low enough that users kno=
w
>> each other and the full email address doesn't need to be displayed.
>> Displaying only the author's username saves a lot of columns on the scre=
en.
>> For example displaying "prarit" instead of "prarit@redhat.com" saves 11
>> columns.
>>
>> Add a "%aU"|"%au" option that outputs the author's email username.
>=20
> I have no position on whether or not this is a useful change.  I don't
> think I'll end up using it, but I can imagine cases where it is useful,
> such as certain corporate environments.  It would be interesting to see
> what others think.
>=20
>> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-for=
mats.txt
>> index b87e2e83e6d0..479a15a8ab12 100644
>> --- a/Documentation/pretty-formats.txt
>> +++ b/Documentation/pretty-formats.txt
>> @@ -163,6 +163,9 @@ The placeholders are:
>>  '%ae':: author email
>>  '%aE':: author email (respecting .mailmap, see linkgit:git-shortlog[1]
>>  =09or linkgit:git-blame[1])
>> +'%au':: author username
>> +'%aU':: author username (respecting .mailmap, see linkgit:git-shortlog[=
1]
>> +=09or linkgit:git-blame[1])
>=20
> I think we need to actually document what "username" means here.  I
> expect you'll have people think that this magically means their
> $HOSTING_PLATFORM username, which it is not.
>=20

Based on Junio's input, I'm going to change the option to "al" and "aL" whe=
re L
means "local-part" as defined by the rfc2822.txt specification, and include=
 a
comment that says "(the portion of the email address preceding the '@' symb=
ol)".
 Admittedly that doesn't convey the meaning of the mailbox concept of the e=
mail
address it does tell a user what is going to be output.


>> diff --git a/pretty.c b/pretty.c
>> index b32f0369531c..2a5b93022050 100644
>> --- a/pretty.c
>> +++ b/pretty.c
>> @@ -706,6 +706,11 @@ static size_t format_person_part(struct strbuf *sb,=
 char part,
>>  =09=09strbuf_add(sb, mail, maillen);
>>  =09=09return placeholder_len;
>>  =09}
>> +=09if (part =3D=3D 'u' || part =3D=3D 'U') {=09/* username */
>> +=09=09maillen =3D strstr(s.mail_begin, "@") - s.mail_begin;
>> +=09=09strbuf_add(sb, mail, maillen);
>> +=09=09return placeholder_len;
>> +=09}
>=20
> This branch doesn't appear to do anything different for the mailmap and
> non-mailmap cases.  Perhaps adding an additional test that demonstrates
> the difference would be a good idea.
>=20

Thanks for the suggestion.  I'll look into it for v2.

P.


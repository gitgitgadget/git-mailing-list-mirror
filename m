From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v3 1/3] string-list: add string_list initialiser helper
 functions
Date: Mon, 23 Jun 2014 06:19:52 -0700
Message-ID: <53A82978.2010900@gmail.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com> <1403518300-23053-2-git-send-email-tanayabh@gmail.com> <53A81F45.70802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 23 15:20:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz4AN-0001WX-27
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 15:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821AbaFWNUD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jun 2014 09:20:03 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:56493 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457AbaFWNUB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 09:20:01 -0400
Received: by mail-pd0-f182.google.com with SMTP id y13so5672243pdi.13
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=FIRPU1OG2p7mkUA8AQK6qZe8JgIaRYnBCFOcUmxkEHQ=;
        b=VxHccIsU8wnejJY3eHVQV9BQlmcj51mIGcsUicxzHc7k2e9TBGc4lyW0x+zLGVWjyK
         +cUeVyWTmqGKqw8+OhPPKG9TzresVEI+1YPPxfQ4NyG82X+8MzNVdgbzOTGmDRRuhJZ1
         oAyZfa/twmtcR5ZlexSkYrnhrFd5fodtqh0n6DAjAPcdUeL28rUpR/sesneUf3wdtE2X
         zCydo7vDioGUiNAovJusiFmHokIV21l5ObTIWxWEKndKzLY0+s8NQqML5TKyPKXjKoR8
         pewc1nV87FzrRapQGX78zRQ/qxT/vajBhrPUzeI44j6lpVHVPjdXTcvUn78lPWw8lNTP
         OSNQ==
X-Received: by 10.68.197.134 with SMTP id iu6mr28908604pbc.164.1403529600199;
        Mon, 23 Jun 2014 06:20:00 -0700 (PDT)
Received: from [192.168.52.169] ([117.254.217.38])
        by mx.google.com with ESMTPSA id ib5sm26946162pbb.55.2014.06.23.06.19.56
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Jun 2014 06:19:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <53A81F45.70802@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252345>

On 06/23/2014 05:36 AM, Torsten B=F6gershausen wrote:
> If we look at the definition below:
> struct string_list {
> 	struct string_list_item *items;
> 	unsigned int nr, alloc;
> 	unsigned int strdup_strings:1;
> 	compare_strings_fn cmp; /* NULL uses strcmp() */
> I think a simple memset() will be easier to read,
> and it will be more future proof:
> In case elements are added, the will have 0 or NULL automatically:

Yes, you are right. After sending the patch I saw that for string_list
initialization the codebase either uses xcalloc or memset and after tha=
t
marks the list as DUP or NODUP.

> void string_list_init_nodup(struct string_list *list)
> {
> 	memset (list, 0, sizeof(*list));
> }
> (But then I wonder if we need the function at all ?)
>=20
> Or does it make sense to have a common function similar to this,
> which covers both cases:
>=20
> void string_list_init(struct string_list *list, int strdup_strings)
> {
> 	memset (list, 0, sizeof(*list));
> 	list->strdup_strings =3D strdup_strings;
> }
>=20

A common function would be much better as other API constructs as strbu=
f
have runtime init functions like the version you have shown above.

Thanks for the review.

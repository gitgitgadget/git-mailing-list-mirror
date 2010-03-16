From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH RFC] cherry: support --abbrev option
Date: Tue, 16 Mar 2010 01:59:33 +0100
Message-ID: <40aa078e1003151759v1825c4fbo62d0d77af81bf66@mail.gmail.com>
References: <1268668999-4188-1-git-send-email-kusmabite@gmail.com>
	 <4B9E69A4.2080304@lsrfire.ath.cx>
	 <40aa078e1003151530y19f10bf1l852a0e5230b11cb6@mail.gmail.com>
	 <4B9EBFEB.5070108@lsrfire.ath.cx>
	 <40aa078e1003151650m549bafdbwdd849e23349ce6a9@mail.gmail.com>
	 <4B9ED500.2040705@lsrfire.ath.cx>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Mar 16 01:59:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrL8H-0005iU-Gx
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 01:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937277Ab0CPA7g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 20:59:36 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:42505 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937270Ab0CPA7f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 20:59:35 -0400
Received: by wwe15 with SMTP id 15so295541wwe.19
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 17:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JtqFHT4YVV9E5XtaULJFFN/zFSAb8qkZk/a+ROD1qdI=;
        b=az4jBvet0yGJDmzeM7IPw5S7SngE2iGF0lTHDRjhBIFM4awJnbvIDAtngxUf4UH93X
         m8uWFj6Uqzc/AlLkJVYslqOhNRa0vawpVK+58kb4V3pvoC9OdvI+UlXZnoYhZggdfuTO
         cqJQywfMKlTqMkjphMWvU0ngsHYAx0em6CH6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=tRA4hf5CuNwkXlRYXT39y36OyhEzZZDtLcgPZdNokFusOSV5DvMEI5YG5Ygsp2rO02
         iNDPorSzzYdnAR3YXomdJn6U/DEgBAdh7Yy0KO4baTDWPuLDVYB0H9lpCB+DJuizhD+g
         /AfaTFIamqiDwL6WFNgvhkstIlCmKv8RINHIU=
Received: by 10.216.165.148 with SMTP id e20mr186505wel.29.1268701173958; Mon, 
	15 Mar 2010 17:59:33 -0700 (PDT)
In-Reply-To: <4B9ED500.2040705@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142287>

On Tue, Mar 16, 2010 at 1:46 AM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 16.03.2010 00:50, schrieb Erik Faye-Lund:
>> It's still just nitpicking, and I appreciate the feed-back. I'm a
>> little bit hesitant here though, for the following reasons:
>> - All other users of OPT__ABBREV (with the exception of ls-files,
>> ls-tree and show-ref) initialize abbrev to it's default value (but
>> they all use DEFAULT_ABBREV).
>> - ls-files and ls-tree (but not show-ref) both does the following,
>> when using abbrev: "abbrev ? find_unique_abbrev(ce->sha1,abbrev) :
>> sha1_to_hex(ce->sha1)".
>> - ls-files, ls-tree and show-ref, all seems to default "abbrev" to
>> zero (by making it a static global).
>> - I want to be consistent with the existing code.
>>
>> So, basically, ls-files and ls-tree seems to think
>> find_unique_abbrev() does not correctly (for this purpose) handle
>> abbrev=3D0. However, show-ref does seem to assume so. Looking at the
>> implementation of find_unique_abbrev(), it is clear that it does. Bu=
t
>> as I said: I want to be consistent, and the variation from show-ref
>> (basically what you're suggesting) is the least common one.
>>
>> So I guess I can either:
>> 1) Change the code to be consistent with show-ref, and submit an
>> additional patch to make ls-files and ls-tree consistent with this.
>> This might have a performance-impact though, since
>> find_unique_abbrev() does some extra work (checking the sha1 for
>> existence and an extra buffer-copy).
>> 2) Change the code as you suggest, and not care so much about consis=
tency.
>> 3) Leave the code to be functionally consistent with those who
>> initialize abbrev to DEFAULT_ABBREV (but with a different default,
>> which in itself is slightly inconsistent).
>>
>> I'm leaning towards 3) for now, but I don't have any strong feelings=
=2E
>
> If you do 2) then it stands 2:2 (ls-files, ls-tree vs. show-ref, cher=
ry). :)
>

True

> find_unique_abbrev() could be streamlined to degrade to sha1_to_hex()
> early on if len is 0 or >=3D 40, without any existence check or copy.=
=2E
>

True indeed, and as an added bonus, we could get rid of duplicate
logic. I don't think the function-call overhead is big enough to care
about for ls-files and ls-tree.

I might go for 2), with the intention of sending some follow-up
patches addressing this...

Luckily, now is sleepy sleepy time, and I can consider this tomorrow ;)

--=20
Erik "kusma" Faye-Lund

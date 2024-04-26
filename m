Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAE4145358
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148450; cv=none; b=Axwdzt/aIxsSkdIw0Yg/7p7ZH+pQf5jATUa7TAvqeHSKAfdJrGQ77a47dwOPxW5snF5QEskE6XN/DitxurOOHPmZLst1YMLidjQKfgbnLya3CGHU1oPp3Hjr7Q6INnEQ5WSx+KrCzSpoDXOt6Ee/5XS6zpiWagYqQDl+QHADxkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148450; c=relaxed/simple;
	bh=8JvQvZXrt+1tCt9Ps2ZQ3w4WJ3CiVr7f5ZR1cPt5to4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gGHhguxyfxSh/zjKoj1XL5vr7t0dvew7oMioCqH9tZmO8wof3mj/Uhp2JtYOQXjccbyXf5hsWG6+15j8bbA6D349NiPfPgliQnS0P3IRNpFtO+TH7LzzH7jS2lar14U1Xrts3eAV3k+Y1DLScfzeXAWtZ+pOoENK9v6LLW9Zz0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lj5gRyuZ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lj5gRyuZ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5300F1DBFC;
	Fri, 26 Apr 2024 12:20:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8JvQvZXrt+1t
	Ct9Ps2ZQ3w4WJ3CiVr7f5ZR1cPt5to4=; b=lj5gRyuZUho5KGltPSGNG6fRpdC7
	1MN3qT9Iy0FWg4tU87NuWbQRROKkZ/oAH7gBBGPWnqYcp8ISIXh6wq/qOjGn24nq
	8p1pJg5zjUUteYevPTCicc4ButXdQRIRufpm0XqZzhZIOXcx99c2bGozvIcTrgt8
	qmpt5D0BNGHuhY0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4B8151DBFA;
	Fri, 26 Apr 2024 12:20:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9C4211DBF9;
	Fri, 26 Apr 2024 12:20:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  Linus Arver <linus@ucla.edu>,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH v3 02/10] trailer: add unit tests for trailer iterator
In-Reply-To: <CAP8UFD0ZHpo7US6dx_WK6F_1JYsBdHunBaW86qM1CzOKaPC-aA@mail.gmail.com>
	(Christian Couder's message of "Fri, 26 Apr 2024 16:51:54 +0200")
References: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
	<pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
	<4ad0fbbb33cab9d5841689cc5660befe6921d515.1714091170.git.gitgitgadget@gmail.com>
	<CAP8UFD0ZHpo7US6dx_WK6F_1JYsBdHunBaW86qM1CzOKaPC-aA@mail.gmail.com>
Date: Fri, 26 Apr 2024 09:20:38 -0700
Message-ID: <xmqqle50ayeh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 EC7B22CA-03E8-11EF-9042-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Apr 26, 2024 at 2:26=E2=80=AFAM Linus Arver via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Linus Arver <linusa@google.com>
>>
>> Test the number of trailers found by the iterator (to be more precise,
>> the parsing mechanism which the iterator just walks over) when given
>> some some arbitrary log message.
>
> s/some some/some/

Right.

>> +static void run_t_trailer_iterator(void)
>> +{
>> +       static struct test_cases {
>> +               const char *name;
>> +               const char *msg;
>> +               size_t num_expected_trailers;
>> +       } tc[] =3D {
>
> ...
>
>> +       };
>> +
>> +       for (int i =3D 0; i < sizeof(tc) / sizeof(tc[0]); i++) {
>> +               TEST(t_trailer_iterator(tc[i].msg,
>> +                                       tc[i].num_expected_trailers),
>> +                    "%s", tc[i].name);
>
> Nit: the members of struct test_cases are used in the (msg,
> num_expected_trailers, name) order, while they are declared in the
> (name, msg, num_expected_trailers) order. I think it would make it a
> bit easier to use in struct test_cases the same order in which they
> are used in the TEST() macro.

I am not sure if I agree.  In the array of struct, being able to
identify each array item with its .name component makes quite a lot
of sense, especially when the .name member is not really part of the
data used in tests but is used as an identifier for the tuple made
of other members (i.e., <msg, num_expected_trailers> in this case).

The TEST() macro is unable to take "name" as an early parameter than
others due to how it wants to create the identifying string (i.e.,
doing an equivalent of strfmt() on tc[i].name), but reordering the
struct members to match the peculiar order the members are used
smells like a tail wagging a dog.

>
>> +       }
>> +}
>> +
>> +int cmd_main(int argc, const char **argv)
>> +{
>> +       run_t_trailer_iterator();
>> +       return test_done();
>> +}
>
> LGTM otherwise.

Thanks.

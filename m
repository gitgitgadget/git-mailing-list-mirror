From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 2/9] ref-filter: implement '--points-at' option
Date: Tue, 09 Jun 2015 00:20:54 +0530
Message-ID: <5575E40E.3000500@gmail.com>
References: <5573520A.90603@gmail.com>	<1433621052-5588-1-git-send-email-karthik.188@gmail.com>	<1433621052-5588-2-git-send-email-karthik.188@gmail.com> <vpqwpzertst.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 20:51:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z228Y-0001HI-3U
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 20:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbbFHSvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 14:51:01 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35869 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbbFHSu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 14:50:59 -0400
Received: by pdjm12 with SMTP id m12so110513575pdj.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 11:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=RWlKPdu1yVXZOMjsAztJNUSnFlzHa8jh2Dy7i6Z+xBk=;
        b=GvHKzYlFvaeUcuOQK/6QRZ5ARTIaGVWlOFviLUzZkCj0JD58gWfvK7MR3SnGiChAD9
         p42vEXMw3hRcOWEefrttIW3F7WkPmEQDj5fNUIyVltHnWpvHvp+I4hJkLsnERAMkoirv
         8/shCoTsQviusPbbNnY9HfbCFGH5hehMOoa88hblDaynOoga2cFgvcJ5M1viL0LQfJaE
         8xeffX8YM9cMZivXrw36KONkIFDf6TyxdUFZqHhgPHo494xnSlLzGJu3ugNi1m/nWokl
         2n7kFHw36xVl+TGCENFo7mCRtAqgdwjqXavMG2ntfTOyq7gJnxHU4FkFJfr/CLi/zVEJ
         KKmg==
X-Received: by 10.68.94.193 with SMTP id de1mr31616443pbb.153.1433789459293;
        Mon, 08 Jun 2015 11:50:59 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id j10sm3291715pdk.48.2015.06.08.11.50.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2015 11:50:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqwpzertst.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271106>

On 06/08/2015 11:01 PM, Matthieu Moy wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +/*
>> + * Given a ref (sha1, refname) see if it points to a one of the sha1s
>> + * in a sha1_array.
>> + */
>> +static int match_points_at(struct sha1_array *points_at, const unsigned char *sha1,
>> +			   const char *refname)
>> +{
>> +	struct object *obj;
>> +
>> +	if (!points_at || !points_at->nr)
>> +		return 1;
>> +
>> +	if (sha1_array_lookup(points_at, sha1) >= 0)
>> +		return 1;
>> +
>> +	obj = parse_object_or_die(sha1, refname);
>> +	if (obj->type == OBJ_TAG &&
>> +	    sha1_array_lookup(points_at, ((struct tag *)obj)->tagged->sha1) >= 0)
>> +		return 1;
>> +
>> +	return 0;
>> +}
>
> There's a similar function in builtin/tag.c that you are not removing.
> You should justify why you are doing this code duplication in the commit
> message (or not do code duplication). It might make sense to add a
> comment next to match_points_at in tag.c saying stg like "this is
> duplicated from ..., will be removed later".
>

Ok will add this :)

-- 
Regards,
Karthik

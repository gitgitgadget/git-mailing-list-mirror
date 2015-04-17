From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] type_from_string_gently: make sure length matches
Date: Fri, 17 Apr 2015 14:11:33 -0700
Message-ID: <xmqqzj66o3y2.fsf@gitster.dls.corp.google.com>
References: <20150417145247.GA2421@peff.net>
	<xmqqd232pjb0.fsf@gitster.dls.corp.google.com>
	<20150417210713.GA7403@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Karthik Nayak <karthik.188@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 23:11:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjDY4-0005R6-DE
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 23:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbbDQVLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 17:11:36 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59140 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751927AbbDQVLf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 17:11:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F8E7497FA;
	Fri, 17 Apr 2015 17:11:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jXodll40gD7wsQJx0xdV9491LZU=; b=UbEIsZ
	/C/D1NghbsT3syyHxvePHQvOxVBj83fv6TJBSQdV3rilz+AFwIba7j//aupyC+J5
	xylj9+cj1ahD5aWvMm8o1ek+Ud0qmqzyfOBwtWpIv9OQYEKP5ZPKf+Iy9NCwGDw8
	fSYyniQVkoEbToOzgPQjonsgNKc5jJyqcnsCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PTqOCiww1pVD79GvDG2cAt3yB5tvKmvV
	c64EAx4eLqqI4eTviRuaRxjAWyQwQoSDdPSaTfTZ87hS8NXHQnyqyw0WfUm8DOZ2
	nC9Ezj4iB8HLCmo8NoU7KU6V/eDZn4Zt8oq489tIfnV9ZmoV0rOLd+0sRkrjaZWY
	C+bpixvg8kw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 06ADA497F9;
	Fri, 17 Apr 2015 17:11:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 740B2497F8;
	Fri, 17 Apr 2015 17:11:34 -0400 (EDT)
In-Reply-To: <20150417210713.GA7403@peff.net> (Jeff King's message of "Fri, 17
	Apr 2015 17:07:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 53D5656E-E546-11E4-B145-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267394>

Jeff King <peff@peff.net> writes:

> I'd be surprised if it appreciably speeds things up, but I guess it is
> not too complicated to do.
>
>> +static struct {
>> +	const char *str;
>> +	int len;
>> +} object_type_name[] = {
>> +	{ NULL, 0 },      /* OBJ_NONE = 0 */
>> +	{ "commit", 6 },  /* OBJ_COMMIT = 1 */
>> +	{ "tree", 4 },	  /* OBJ_TREE = 2 */
>> +	{ "blob", 4 },    /* OBJ_BLOB = 3 */
>> +	{ "tag", 3 },     /* OBJ_TAG = 4 */
>>  };
>
> I had envisioned a macro like:
>
>   #define SIZED_STRING(x) { (x), (sizeof(x) - 1) }
>
> though perhaps that is overkill for such a short list (that we don't
> even expect to change).

Sounds good (either way ;-)

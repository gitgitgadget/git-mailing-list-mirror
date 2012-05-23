From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] index-pack: use streaming interface for collision
 test on large blobs
Date: Wed, 23 May 2012 09:03:50 -0700
Message-ID: <7vr4ua28bd.fsf@alter.siamese.dyndns.org>
References: <1337172630-23679-1-git-send-email-pclouds@gmail.com>
 <1337782191-10091-1-git-send-email-pclouds@gmail.com>
 <1337782191-10091-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 18:04:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXE2Z-0002GY-HL
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 18:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625Ab2EWQDz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 12:03:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36278 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845Ab2EWQDy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 May 2012 12:03:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C93698D34;
	Wed, 23 May 2012 12:03:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NDbtNE+3YOJd
	KK2Pys2sm9APO7I=; b=ucIEep6OCvmQB/17btzNIqVgX4qNIOdnPGCFzf5wHcGc
	tcSaPjxdn0cVZW09QkttO2/1GCnQfO8SlDLg2eCFt7QFzAVZ2z/i9vQqTmEwcD0B
	X+3A3Cb01U2n3f1lNY6HYztCJm4DxCpwl1h1/gDrMnKL4KjOw8VXQ/7D+zohhf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Q5DYMR
	KetEzzOka7D3iHtojKGHRrjxVMmRi2dekuybMrp6nGsvAFvudaSIlc09aifw04D9
	bATYdevj9JqICb8/mqCLpUdguUGu6UL3O50UPJbMnHZIKKX6rn3v4ru2+vQGMzUE
	3OVhtRiNg8/ZR9IEb18qiOU4vAJZyBylShShY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C01208D32;
	Wed, 23 May 2012 12:03:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8EC38D2F; Wed, 23 May 2012
 12:03:51 -0400 (EDT)
In-Reply-To: <1337782191-10091-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 23 May
 2012 21:09:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3C5D4C2-A4F0-11E1-8581-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198303>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  the use of sha1_object_info() instead of has_sha1_file() is the caus=
e
>  of 6/6 as it is called on non-existent objects too.

I think it is wrong to call object-info before knowing if it even exist=
s.

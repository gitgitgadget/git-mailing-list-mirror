From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] describe: Use for_each_rawref
Date: Tue, 07 Dec 2010 11:49:27 -0800
Message-ID: <7vsjy9pdmg.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu>
 <20101203084348.GD18202@burratino>
 <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu>
 <20101206073214.GA3745@burratino>
 <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
 <20101207095818.GB1867@neumann>
 <alpine.DEB.2.02.1012071320240.23348@dr-wily.mit.edu>
 <alpine.DEB.2.02.1012071325100.23348@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Anders Kaseorg <andersk@ksplice.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 20:49:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ3Xt-0000nK-NB
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 20:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214Ab0LGTtr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 14:49:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35657 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190Ab0LGTtr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 14:49:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EB12833A8;
	Tue,  7 Dec 2010 14:50:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PLXdRHU1vXrB
	Ejzn8PPMNd+gL4M=; b=KSePQYYIH78nFgvQio2S2pCIR7ES/q2eNP3o/uOEp7/T
	Tu9cyZ2IxMO66nZM5upUEmi9iypbJjXNm6Q9yFOPH7aKFdvGXr7IwUqg1O1OWx10
	j1hP7S5UmY+OyLcC6gUD5rhdTrbVI7vUw1IvVndrAbVeCOHpD+Bikp8Yg2vH+GU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nnixHk
	VHXbrcIzTn9q/ANXSmZ4olSZgbUblgNA0crQwt61ySJEkBIAnjwgSGbZUka8sPP7
	5+OVcvpycpTkqlg/DBci81ByoKZeVRmXX/BweUGMY+IE5men/uWpCyp1Ugg+ne1U
	MVafoxigsulsajNKbsWbaiQ2EMd3Dk+rmzkVs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 87AF033A4;
	Tue,  7 Dec 2010 14:50:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3DDCF33A2; Tue,  7 Dec 2010
 14:49:51 -0500 (EST)
In-Reply-To: <alpine.DEB.2.02.1012071325100.23348@dr-wily.mit.edu> (Anders
 Kaseorg's message of "Tue\, 7 Dec 2010 13\:26\:45 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2DC246F0-023B-11E0-9A04-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163121>

Anders Kaseorg <andersk@ksplice.com> writes:

> On Tue, 7 Dec 2010, Anders Kaseorg wrote:
>> Signed-off-by: Anders Kaseorg <andersk@ksplice.com>
>>=20
>> diff --git a/builtin/describe.c b/builtin/describe.c
>
> (Gaaah, sorry, I accidentally used format-patch -p here.  Won=E2=80=99=
t happen=20
> again.  :-) )

The default will work just fine, no?

Also labelling them like "[PATCH v2 1/2]" would have been nicer to spot
the progress of the series.

Thanks.

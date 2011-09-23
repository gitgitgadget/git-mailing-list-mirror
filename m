From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] branch: teach --edit-description option
Date: Fri, 23 Sep 2011 12:04:48 -0700
Message-ID: <7v62kjulkf.fsf@alter.siamese.dyndns.org>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org>
 <1316729362-7714-1-git-send-email-gitster@pobox.com>
 <1316729362-7714-4-git-send-email-gitster@pobox.com>
 <20110923094721.GA8397@duynguyen-vnpc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 21:04:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7B3P-0006ug-MT
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 21:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286Ab1IWTEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 15:04:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46707 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981Ab1IWTEu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 15:04:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70CA4401D;
	Fri, 23 Sep 2011 15:04:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gb/M+paEgjrW5kv3kkfsnYPLdh8=; b=gnX745
	YwAOyaF2iFCCM35XO549PX5BSKzMSCz3LNIAOXYTsTrDp6CRToJvQm4lNqOCTAZB
	MDN9/mR4gIntGugO04ORfZX1dXJ75avSmQWxJClhpmJFMAwGg3sxHQCQWykIakKk
	qy5QhPV38AHf7OkC2akyGyK64T4vhZf74eOyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ro25CDIEuE19Z88F/yL+X/hQipY9jo+l
	0Vhhb6U5RZODEcEbXeNmVb8518SbMv8xxVrk4B72DAZxr3hu0fs6ABw+ApSg4kES
	ljyLoKQtp18M3025miWE2tORiYyFQVZMMpjWpHmARcEv/YfANs/Et+m1T9Vmyvbf
	22Xo2hVlImc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6894D401C;
	Fri, 23 Sep 2011 15:04:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0C38401B; Fri, 23 Sep 2011
 15:04:49 -0400 (EDT)
In-Reply-To: <20110923094721.GA8397@duynguyen-vnpc> (Nguyen Thai Ngoc Duy's
 message of "Fri, 23 Sep 2011 19:47:21 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E95CF544-E616-11E0-8BB1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181991>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Thu, Sep 22, 2011 at 03:09:19PM -0700, Junio C Hamano wrote:
>> +	if (launch_editor(git_path(edit_description), &buf, NULL)) {
>> +		strbuf_release(&buf);
>> +		return -1;
>> +	}
>> +	stripspace(&buf, 1);
>> +
>> +	strbuf_addf(&name, "branch.%s.description", branch_name);
>> +	status = git_config_set(name.buf, buf.buf);
>
> I suppose a Windows editor mave save the description with \r\n
> ending. Perhaps a patch like this to avoid messing up config file?

Doesn't stripspace() cleanse that already?

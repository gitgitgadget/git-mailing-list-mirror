From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] rebase -i: optimize the creation of the todo file
Date: Fri, 09 Mar 2012 01:47:51 -0800
Message-ID: <7vpqcm85rs.fsf@alter.siamese.dyndns.org>
References: <1331214777-9455-1-git-send-email-domq@google.com>
 <CAFfmPPMt_o1Rg-Pvuh_KpARrASwfYSq74UN3ayp=LVzLJ0oj=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dominique Quatravaux <domq@google.com>, git@vger.kernel.org,
	Thomas Rast <trast@inf.ethz.ch>,
	Johannes Sixt <j.sixt@viscovery.net>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 10:48:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5wQZ-0002Xc-PW
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 10:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948Ab2CIJrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 04:47:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38751 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077Ab2CIJrx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 04:47:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 926E65194;
	Fri,  9 Mar 2012 04:47:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zlb6n+tD1LlQAIu9AGrmgd8tFvw=; b=EnqCT3
	Uux5tie//xWdx5OqftDc/kzZ3yUBEPSQYgpFGgKuVPXnJKN+RWBCsgIuSd5GZVMR
	zYLf+hg1aWnd+O7ePa39lsgv/2Bq8X5JNwtIXy7WyqTx7DTE1qr4obBg8MQteDuZ
	1//FEFR/mnffA6PW7UTWrRJBv7oUotyXpDIXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VnNFQuonpX5w+WRxxkO7CtcyYoQQkxEi
	rxeoqFpIT0Ytf8uhR5nwQ7nZeDk8K1sQAL7T+eQcVWRGthT8tRUQX9dRg47WqUhY
	Tk+L/XeSueZi9VodQ0TAemVLJe64Nb1MVfgjBPoujhc6s7VQnWsj4/X/d2Zww9w6
	J5YLPkEisJE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88D205193;
	Fri,  9 Mar 2012 04:47:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17F9D5192; Fri,  9 Mar 2012
 04:47:53 -0500 (EST)
In-Reply-To: <CAFfmPPMt_o1Rg-Pvuh_KpARrASwfYSq74UN3ayp=LVzLJ0oj=A@mail.gmail.com> (David
 Barr's message of "Fri, 9 Mar 2012 16:00:19 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0C2EFB6-69CC-11E1-B6C5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192701>

David Barr <davidbarr@google.com> writes:

> I do notice however that the output being fed to sed expands like so:
>
>   commit >634a5f265ad729b91266de65272e2b5a35d05b1c
>   >634a5f265ad729b91266de65272e2b5a35d05b1c 634a5f2 INSTALL: warn [...]
>   commit >828ea97de486c1693d6e4f2c7347acb50235a85d
>   >828ea97de486c1693d6e4f2c7347acb50235a85d 828ea97 Git 1.7.9
>
> Maybe the format spec and sed command could use a little tuning.

Why would that be a problem, though?  The sed script picks only
lines that begin with '>' and discards the traditional diff-tree
style per commit header, no?

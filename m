From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: The "Owner" column can be hidden
Date: Wed, 31 Mar 2010 02:48:57 -0700
Message-ID: <7vy6h8om7q.fsf@alter.siamese.dyndns.org>
References: <1270026409-29543-1-git-send-email-jstepien@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jan =?utf-8?B?U3TEmXBpZcWE?= <jstepien@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Mar 31 11:49:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwuY6-0004eD-A1
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 11:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933097Ab0CaJtJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 05:49:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933051Ab0CaJtE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Mar 2010 05:49:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 07AF6A6603;
	Wed, 31 Mar 2010 05:49:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=ghzcxTqlgTCqm10BwptiIwfSN
	do=; b=R1JXvX349BdyKr6K9wA6BbxIMYqt9s97MYvnu8LgtQRmHcqKxow7BvMa1
	gfzGBrhPfyAGUvNhZCtEr127JMjgM4/mF0edpbaAN6lHGQJjSQl7TCKgegIx5cpW
	pAnpoCMpnfy3v5T3NxYMBa0TMnzopYrWvdeNnTzD7Pfm/X41Sk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=nC/r+vOaiTKmOE9FrHe
	LEM7/VCk2cOEujTwaB1cEIhVFgqgqPJiXFUO+T69W5V3gwKx4AzoDAKdYGqnfGBs
	4xcvokpap1uFWHy37EnP6efxHDxfElPC3QLBWB/6WG4jxCgSRS+d/qD1fAZ0ZFhS
	873Tc0YS8kPTlXP0VSG054Ng=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DAB84A6602;
	Wed, 31 Mar 2010 05:49:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50594A6601; Wed, 31 Mar
 2010 05:48:59 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A2D95AA2-3CAA-11DF-A475-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143657>

Jan St=C4=99pie=C5=84  <jstepien@users.sourceforge.net> writes:

> This commit adds $show_owner_column configuration variable which allo=
ws
> to hide the project list "Owner" column if desired.
>=20
> @@ -4430,7 +4433,7 @@ sub git_project_list_body {
>  		}
>  		print_sort_th('project', $order, 'Project');
>  		print_sort_th('descr', $order, 'Description');
> -		print_sort_th('owner', $order, 'Owner');
> +		print_sort_th('owner', $order, 'Owner') if $show_owner_column;
>  		print_sort_th('age', $order, 'Last Change');

Ugly.  Think what you would do if somebody else asks you to allow him t=
o
omit 'Description', or perhaps 'Last Change'.

I would understand if the change was to introduce a configuration varia=
ble
of the array type @project_column whose default value is qw(project des=
cr
owner age) that is used to control which columns are shown in what orde=
r.

If it is undesirable to allow reordering the columns, the configuration
should at least be %omit_project_column used like this, no?

	print_sort_th('project', $order, 'Project')
        	unless $omit_project_column{'project'};
	print_sort_th('descr', $order, 'Description')
        	unless $omit_project_column{'descr'};
	...

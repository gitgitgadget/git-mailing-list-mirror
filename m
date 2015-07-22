From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 1/9] ref-filter: add option to align atoms to the left
Date: Wed, 22 Jul 2015 20:44:08 +0200
Message-ID: <vpqwpxsnibr.fsf@anie.imag.fr>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
	<1437246749-14423-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 20:44:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHz0G-0000vu-Vq
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 20:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbbGVSoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 14:44:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41014 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355AbbGVSoO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 14:44:14 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6MIi6cu013037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 22 Jul 2015 20:44:06 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6MIi8Ag029528;
	Wed, 22 Jul 2015 20:44:08 +0200
In-Reply-To: <1437246749-14423-2-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 19 Jul 2015 00:42:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 22 Jul 2015 20:44:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6MIi6cu013037
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438195448.86799@3+/Eqp60UWEGVrAI640b7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274452>

Karthik Nayak <karthik.188@gmail.com> writes:

> +			strtoul_ui(valp, 10, &ref->align_value);
> +			if (ref->align_value < 1)
> +				die(_("Value should be greater than zero"));

You're not checking the return value of strtoul_ui, which returns -1
before assigning align_value if the value can't be parsed. As a result,
you're testing an undefined value in the 'if' statement in this case.

You should test the return value and issue a distinct error message in
this case like

if (strtoul_ui(valp, 10, &ref->align_value))
	die(_("positive integer expected after ':' in align:%u\n",
	    ref_align_value));

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

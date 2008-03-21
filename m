From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH resend 1/2] Make git-svn tests behave better on OS X
Date: Fri, 21 Mar 2008 00:04:27 -0700
Message-ID: <7vod98r210.fsf@gitster.siamese.dyndns.org>
References: <1206043729-61810-1-git-send-email-kevin@sb.org>
 <20080321065824.GB28144@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:05:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcbJb-0001LC-KZ
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 08:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbYCUHEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 03:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbYCUHEn
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 03:04:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41425 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbYCUHEn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 03:04:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E90FA1060;
	Fri, 21 Mar 2008 03:04:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 33148105F; Fri, 21 Mar 2008 03:04:34 -0400 (EDT)
In-Reply-To: <20080321065824.GB28144@muzzle> (Eric Wong's message of "Thu, 20
 Mar 2008 23:58:24 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77726>

Eric Wong <normalperson@yhbt.net> writes:

> Kevin Ballard <kevin@sb.org> wrote:
> ...
> I seem to recall seeing a RHEL or CentOS machine using /usr/sbin/httpd,
> somewhere, too.  Any non-Debian users care to comment/add more paths?
> ...
>> -SVN_HTTPD_MODULE_PATH=${SVN_HTTPD_MODULE_PATH-'/usr/lib/apache2/modules'}
>> -SVN_HTTPD_PATH=${SVN_HTTPD_PATH-'/usr/sbin/apache2'}
>> +if test `uname -s` = Darwin
>> +then
>> +	SVN_HTTPD_MODULE_PATH=${SVN_HTTPD_MODULE_PATH-'/usr/libexec/apache2'}
>> +	SVN_HTTPD_PATH=${SVN_HTTPD_PATH-'/usr/sbin/httpd'}
>> +else
>> +	SVN_HTTPD_MODULE_PATH=${SVN_HTTPD_MODULE_PATH-'/usr/lib/apache2/modules'}
>> +	SVN_HTTPD_PATH=${SVN_HTTPD_PATH-'/usr/sbin/apache2'}
>> +fi

I really hate this patch.

Why do we even _care_ about uname?

Wouldn't something like this be a lot easier to maintain in the longer run?

    for d in \
            "$SVN_HTTPD_MODULE_PATH" \
            /usr/lib/apache2/modules \
            /usr/libexec/apache2 \
    ; do
            if test -d "$d"
            then
                    SVN_HTTPD_MODULE_PATH="$d"
                    break
            fi
    done

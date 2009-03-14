From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Autoconf: Disable inline for compilers that don't
 support it.
Date: Sat, 14 Mar 2009 13:46:52 -0700
Message-ID: <7vy6v7al37.fsf@gitster.siamese.dyndns.org>
References: <20090114223832.GC30710@genesis.frugalware.org>
 <20090314010421.GA6642@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Allan Caffee <allan.caffee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 14 21:48:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Liamb-0008M4-Pb
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 21:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbZCNUq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 16:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbZCNUq7
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 16:46:59 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62743 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbZCNUq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 16:46:58 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 86A7C67B6;
	Sat, 14 Mar 2009 16:46:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0040F67B3; Sat,
 14 Mar 2009 16:46:53 -0400 (EDT)
In-Reply-To: <20090314010421.GA6642@linux.vnet> (Allan Caffee's message of
 "Fri, 13 Mar 2009 21:04:21 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 41CA339C-10D9-11DE-93DB-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113261>

Allan Caffee <allan.caffee@gmail.com> writes:

> The Autoconf macro AC_C_INLINE will redefine the inline keyword to whatever the
> current compiler supports (including possibly nothing).
>
> Signed-off-by: Allan Caffee <allan.caffee@gmail.com>

As far as I can tell, this makes scriptlet to set ac_cv_c_inline and then
the result is written to confdefs.h:

    case $ac_cv_c_inline in
      inline | yes) ;;
      *)
        case $ac_cv_c_inline in
          no) ac_val=;;
          *) ac_val=$ac_cv_c_inline;;
        esac
        cat >>confdefs.h <<_ACEOF
    #ifndef __cplusplus
    #define inline $ac_val
    #endif
    _ACEOF
        ;;
    esac

which is used only during the ./configure run but not during the actual
build.

What am I missing?

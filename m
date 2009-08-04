From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: new option to hide remote refs
Date: Mon, 03 Aug 2009 23:28:18 -0700
Message-ID: <7vab2g6qkd.fsf@alter.siamese.dyndns.org>
References: <55b7e43bcd59aa64c70edde83ac87147aa0091bb.1249336225.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Thell Fowler <tbfowler4@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 04 08:28:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYDVm-0002xm-FU
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 08:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbZHDG23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 02:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbZHDG22
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 02:28:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38532 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932430AbZHDG22 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 02:28:28 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A28921CDBE;
	Tue,  4 Aug 2009 02:28:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0CA2D1CDBB; Tue,  4 Aug 2009
 02:28:19 -0400 (EDT)
In-Reply-To: <55b7e43bcd59aa64c70edde83ac87147aa0091bb.1249336225.git.trast@student.ethz.ch> (Thomas Rast's message of "Mon\, 3 Aug 2009 23\:53\:36 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 05C194BA-80C0-11DE-A055-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124755>

Thomas Rast <trast@student.ethz.ch> writes:

> @@ -1689,7 +1690,7 @@ proc readrefs {} {
>  	if {![string match "refs/*" $ref]} continue
>  	set name [string range $ref 5 end]
>  	if {[string match "remotes/*" $name]} {
> -	    if {![string match "*/HEAD" $name]} {
> +	    if {![string match "*/HEAD" $name] && !$hideremotes} {
>  		set headids($name) $id
>  		lappend idheads($id) $name
>  	    }

Hmm, I wonder if it would be more useful to extend this by using $skiprefs
pattern instead, like so:

>  	if {![string match "refs/*" $ref]} continue
>  	set name [string range $ref 5 end]
+	if {$skiprefs != "" && [string match $skiprefs $name]} continue
>  	if {[string match "remotes/*" $name]} {
> 	    if {![string match "*/HEAD" $name]} {
	...

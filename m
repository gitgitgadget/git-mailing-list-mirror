From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-help: add -w|--web option to display html man page in a browser.
Date: Thu, 06 Dec 2007 22:04:03 -0800
Message-ID: <7v1w9z9h2k.fsf@gitster.siamese.dyndns.org>
References: <20071202060755.4d6d5ec8.chriscool@tuxfamily.org>
	<7v3aufeowe.fsf@gitster.siamese.dyndns.org>
	<200712070635.18018.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Wong <normalperson@yhbt.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 07:11:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0WQb-0001vz-44
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 07:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbXLGGKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 01:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbXLGGKs
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 01:10:48 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:38891 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbXLGGKp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 01:10:45 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B7C4D25B7;
	Fri,  7 Dec 2007 01:04:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D6E9325B4;
	Fri,  7 Dec 2007 01:04:10 -0500 (EST)
In-Reply-To: <200712070635.18018.chriscool@tuxfamily.org> (Christian Couder's
	message of "Fri, 7 Dec 2007 06:35:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67383>

Christian Couder <chriscool@tuxfamily.org> writes:

>> > +# Directories that may contain html documentation:
>> > +install_html_dir="$PREFIX/share/doc/git-doc"
>> > +rpm_dir="$PREFIX/share/doc/git-core-$GIT_VERSION"
>>
>> ... doing this is wrong. People can set htmldir to somewhere other than
>> $(prefix)/share/doc/git-doc while building and installing, but you are
>> not telling the munged script where it is.
>
> Yeah, I sent a fix for this.

Why do you even need to fallback?  I'd rather drop these two fallbacks
entirely.

Distros have their own html documentation layout policy, so I suspect
they will patch this part to their liking anyway, and this point will
mostly become moot.  For source distribution, I'd prefer to point at
the place we know we are installing in.

>> > +init_browser_path() {
>> > +	browser_path=`git config browser.$1.path`
>> > +	test -z "$browser_path" && browser_path=$1
>> > +}
>>
>> Please do not contaminate the config file with something the user can
>> easily use a lot more standardized way (iow $PATH) to configure to his
>> taste.
>>
>> I'd suggest dropping this bit.
>
> I stole this part from "git-mergetool.sh":
>
> init_merge_tool_path() {
>         merge_tool_path=`git config mergetool.$1.path`
>         if test -z "$merge_tool_path" ; then
>                 case "$1" in
>                         emerge)
>                                 merge_tool_path=emacs
>                                 ;;
> ...
> }
>
> So we should either drop it in "git-mergetool.sh" too or keep it in both 
> scripts.

I think this is an irrelevant defense.  If others are doing bad, that is
not a justification to make things worse.

In the case of mergetool, it has case "$merge_tool" that can be spelled
totally differently from path (e.g. emerge and emacs), so that function
itself is semi justified.  For browser I do not think there isn't such
justification.

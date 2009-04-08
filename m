From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git remote update: Report error for non-existing
 groups
Date: Wed, 08 Apr 2009 01:20:36 -0700
Message-ID: <7vy6ubo8tn.fsf@gitster.siamese.dyndns.org>
References: <1239025262-16960-1-git-send-email-finnag@pvv.org>
 <1239025262-16960-2-git-send-email-finnag@pvv.org>
 <7vprfnubyi.fsf@gitster.siamese.dyndns.org> <20090408080738.GA24386@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Wed Apr 08 10:23:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrT3z-0004bW-RB
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 10:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763632AbZDHIUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 04:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763863AbZDHIUt
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 04:20:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58733 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763548AbZDHIUr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 04:20:47 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 369B0A8929;
	Wed,  8 Apr 2009 04:20:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 18DC3A8928; Wed,
  8 Apr 2009 04:20:37 -0400 (EDT)
In-Reply-To: <20090408080738.GA24386@pvv.org> (Finn Arne Gangstad's message
 of "Wed, 8 Apr 2009 10:07:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 27B8E098-2416-11DE-8EFA-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116061>

Finn Arne Gangstad <finnag@pvv.org> writes:

> On Tue, Apr 07, 2009 at 07:16:21PM -0700, Junio C Hamano wrote:
>> Finn Arne Gangstad <finnag@pvv.org> writes:
>> 
>> > @@ -1227,8 +1229,11 @@ static int update(int argc, const char **argv)
>> >  
>> >  	remote_group.list = &list;
>> >  	for (i = 1; i < argc; i++) {
>> > +		int groups_found = 0;
>> >  		remote_group.name = argv[i];
>> > -		result = git_config(get_remote_group, NULL);
>> > +		result = git_config(get_remote_group, &groups_found);
>> > +		if (!groups_found && (i != 1 || strcmp(argv[1], "default")))
>> > +			die("No such remote group: '%s'", argv[i]);
>> 
>> I think you are trying to be silent about the case where the caller feeds
>> you the default_argv[] array with this, but do we want to be more explicit
>> about this so that we do die when the end user explicitly says "default"
>> from the command line?
>
> Are you thinking that "git remote update default" should only be allowed
> if you have configured a group named default?

I have no preference either way, and that is why I asked.

"git remote update" without explicit "default" is obviously what your code
try not to say "No such remote group" to, and that probably is a sane
thing to do.

I don't know what users want to see when they say "default" explicitly
without having an explicit configuration.  Should it do the same thing as
"git remote update"?

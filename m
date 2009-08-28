From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] upload-pack: expand capability advertises additional
 refs
Date: Fri, 28 Aug 2009 12:07:21 -0700
Message-ID: <7vr5uvlpue.fsf@alter.siamese.dyndns.org>
References: <7vocq5q0j7.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0908240144530.28290@iabervon.org>
 <alpine.LNX.2.00.0908242212260.26869@reaper.quantumfyre.co.uk>
 <alpine.LFD.2.00.0908242001250.6044@xanadu.home>
 <20090825021223.GE1033@spearce.org> <7vab1osc2m.fsf@alter.siamese.dyndns.org>
 <20090825061248.GG1033@spearce.org> <7vy6p8pfm1.fsf@alter.siamese.dyndns.org>
 <20090825151424.GJ1033@spearce.org> <20090826021057.GL1033@spearce.org>
 <20090828173007.GX1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 28 21:08:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh6o8-0002Qq-4x
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 21:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbZH1THk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 15:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752550AbZH1THk
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 15:07:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403AbZH1THj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 15:07:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A7121C9E2;
	Fri, 28 Aug 2009 15:07:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YETy2elDingIxepfwm44CeZSm5g=; b=hiAL73
	Ow6UDetqyVARKUP9+aCac/Ozxv3NgAY3Wc+xzq5bTKtaX2zS4W7NLbOknQOiCCs0
	5rpQ59msTyyPs5e06t/tR9FcwiXy2YzmvGmjiOgzn7N3M7ClQk8ReOv3e1Kvu1h4
	t51F3Cbmd6WUEC4QgUpulV+gZA5K1It5izCPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kmk3+NzkKI7qlcJmSWGYtMP74kZ3NyuK
	N1GEu8aGaMkDZeKTIn+yU98jKaodQaAe6SQPle5+mKdWJdCezS87SOzlWFI3ssji
	UzvjZUnVqepRiMpeIGKYkt4JPq6shDyoHkzC9akUZYzDiwVj9+65nPKK0mes/9uH
	kszXeVX0hLc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2565C1C9E0;
	Fri, 28 Aug 2009 15:07:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E02E41C9DB; Fri, 28 Aug
 2009 15:07:22 -0400 (EDT)
In-Reply-To: <20090828173007.GX1033@spearce.org> (Shawn O. Pearce's message
 of "Fri\, 28 Aug 2009 10\:30\:07 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0AE626AA-9406-11DE-8123-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127333>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>  static void upload_pack(void)
>  {
> +	git_config(upload_pack_config, NULL);
> +	if (!configured_advertise)
> +		push_advertise("refs/*");
> +
> +	head_ref(scan_ref, NULL);
> +	for_each_ref(scan_ref, NULL);
> +
>  	reset_timeout();
> -	head_ref(send_ref, NULL);
> -	for_each_ref(send_ref, NULL);
> -	packet_flush(1);
> +	send_refs();
>  	receive_needs();
>  	if (want_obj.nr) {
>  		get_common_commits();
> @@ -652,6 +764,7 @@ int main(int argc, char **argv)
>  
>  	git_extract_argv0_path(argv[0]);
>  	read_replace_refs = 0;
> +	push_advertise("HEAD");
>  
>  	for (i = 1; i < argc; i++) {
>  		char *arg = argv[i];
> @@ -667,6 +780,10 @@ int main(int argc, char **argv)
>  			daemon_mode = 1;
>  			continue;
>  		}
> +		if (!prefixcmp(arg, "--expand=")) {
> +			push_advertise(arg + 9);
> +			continue;
> +		}
>  		if (!strcmp(arg, "--")) {
>  			i++;
>  			break;

This arrangement of push_advertise() calls are rather curious.  I think
your design guidelines are:

 - We do want to advertise HEAD, so it can (and should) be unconditional;

 - We may want to restrict with configuration, or use "refs/*" as the
   fallback default;

 - We may want to (extend|replace) advertised set configured in the
   configuration file.

I would naively expect the above to be implemented in this order:

 - In main, first thing is to do the git_config() bit; if to_advertise is
   non-empty after git_config() returns, we have seen upload.advertise.
   Otherwise we haven't.  Push "refs/*" in the latter case.

 - Then, parse the command line.  Do we see "--expand="?  If so:

   . When handling the first "--expand=", clear to_advertise list.  This
     step is optional---necessary only if we want to make config variable
     override-able ;-);

   . Then, push the pattern in.

 - And finally push "HEAD" in unconditionally.

Which would mean a few things:

 - Your version always extends what is read from the configuration with
   --expand=, but I think replacing would be the right thing to do.

 - configured_advertise global variable can go.

 - Instead, to implement "--expand= replaces", we need a local variable in
   main() to remember if we already cleared to_advertise of the patterns
   read from the configuration file, and use it in the part that parses
   "--expand=".

But I may not be thinking clearly; I was up all night because I couldn't
sleep under loud noises of fire-fighting helicopters...

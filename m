From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG?] fetch into shallow sends a large number of objects
Date: Thu, 10 Mar 2016 19:20:20 +0700
Message-ID: <20160310122020.GA24007@lanh>
References: <20160307221539.GA24034@sigill.intra.peff.net>
 <xmqqio0xn93q.fsf@gitster.mtv.corp.google.com>
 <20160308121444.GA18535@sigill.intra.peff.net>
 <CACsJy8Dk_g1O98UsDaeVS3VXmE2Mn5aR+w1OiFir+QwyJYLVZQ@mail.gmail.com>
 <20160308132524.GA22866@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 10 13:20:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adza3-0001XY-1J
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 13:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802AbcCJMU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 07:20:27 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35307 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779AbcCJMUY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 07:20:24 -0500
Received: by mail-pa0-f41.google.com with SMTP id td3so39374967pab.2
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 04:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3xd8K/3bXcXUV4mscP3tB//LaVa2iMYnJyCWd8oz+ZU=;
        b=sI04h7qXSed6LlAkkkFinJm05+HmLuKeH1kgtWpwxKU1ZxFi+c5hMenC/UQ9vIEhDi
         VlRqBeQHy0dCSI+znNMBJYN2W9pnPWkZTwPD3+ZDa9SLZHEKo4qAeHQysrGGhIZ2bRhx
         8kO8WI+t7cAdhjqLzyQqXvk0HgWoyetbi1U/oeTEtGn0AI/z8r1hEtDSs5UkNQ0R/3B6
         yq57NCsMELel1DVXWk0uspliGc7dg6+YGgNh1aVMQaFep0qAeJuu2f15dvwmJ8HhpLSX
         p8uGU/pQ7VNkyOHsmMh5ZVdqg94GZhjp160L5WjRNYO8mGznsk7x1SJdx5aub/VXEsHT
         O+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3xd8K/3bXcXUV4mscP3tB//LaVa2iMYnJyCWd8oz+ZU=;
        b=ZmvI7L2gNMZiWkZ/zx6VocH9hL1rD9lFw+INcjeA/JZzjjpD0O4VrZidW6oLs7qT1b
         6NM6ZQ04+Gu0tE6hf9tuM2HGZfrZLo8O0BgI0NHn0gELUZeSa36FrHlPkFFGbJ0X5scD
         H8KpDquLNRBQLUCoOJMToqUpNRhjRfrlrtYaQfWPH2uPHf8zC1V6lZFzal9ssT2odERE
         JvZH0kjENPilCa0p6U3BK25DZcMkRTFKUBlY3Y40qiWPWRmMHAJtKV5q2cOQRE8vbpIu
         esXpqvm/51xMJG+sA0TX1Yhh7ccxCDiOkgE3MduRkWJ07eRng7LIl55MFzT/IGh1IQ8I
         RsaQ==
X-Gm-Message-State: AD7BkJLg5rtmP1hZi/vtCUbjK94coRr/CuhbZFZ9rVpSW9Tat2i5Ap/G3WQ2kIyRMiweEQ==
X-Received: by 10.66.246.165 with SMTP id xx5mr4439138pac.87.1457612423130;
        Thu, 10 Mar 2016 04:20:23 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id v9sm5364679pfi.50.2016.03.10.04.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Mar 2016 04:20:21 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 10 Mar 2016 19:20:20 +0700
Content-Disposition: inline
In-Reply-To: <20160308132524.GA22866@sigill.intra.peff.net>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288619>

On Tue, Mar 08, 2016 at 08:25:24AM -0500, Jeff King wrote:
> I think this patch does roughly the right thing:
> 
> diff --git a/upload-pack.c b/upload-pack.c
> index 4859535..da76f70 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -833,12 +833,41 @@ static void receive_needs(void)
>  		deepen_by_rev_list(av.argc, av.argv, &shallows);
>  		argv_array_clear(&av);
>  	}
> -	else
> -		if (shallows.nr > 0) {
> -			int i;
> -			for (i = 0; i < shallows.nr; i++)
> -				register_shallow(shallows.objects[i].item->oid.hash);
> +	else if (shallows.nr > 0) {
> +		struct rev_info revs;
> +		struct argv_array av = ARGV_ARRAY_INIT;
> +		struct commit *c;
> +		int i;
> +
> +		argv_array_push(&av, "rev-list");
> +		argv_array_push(&av, "--boundary");

Nice. I didn't know about --boundary. But will it work correctly in
this case?

       --- B ---- C ---- F
          /      /
     --- D ---- E ---- G

C and D will be current shallow cut points. People "want" F and G.
"rev-list --boundary F G ^C ^D" would mark E as boundary/shallow too,
correct? If so the history from G will be one depth short on a normal
fetch.

> +		for (i = 0; i < want_obj.nr; i++) {
> +			struct object *o = want_obj.objects[i].item;
> +			argv_array_push(&av, oid_to_hex(&o->oid));
>  		}
> +		for (i = 0; i < shallows.nr; i++) {
> +			struct object *o = shallows.objects[i].item;
> +			argv_array_pushf(&av, "^%s", oid_to_hex(&o->oid));
> +		}
> +
> +		init_revisions(&revs, NULL);
> +		setup_revisions(av.argc, av.argv, &revs, NULL);
> +		if (prepare_revision_walk(&revs))
> +			die("revision walk setup failed");
> +
> +		while ((c = get_revision(&revs))) {
> +			if (!(c->object.flags & BOUNDARY))
> +				continue;
> +			register_shallow(c->object.oid.hash);
> +			packet_write(1, "shallow %s",
> +				     oid_to_hex(&c->object.oid));
> +		}

>  ...
> _But_, the client is not prepared to handle this. We send "shallow"
> lines that it is not expecting, since it did not ask for any depth. So I
> think this logic would have to kick in only when the client tells us to
> do so.

Urgh.. not good. Perhaps a new extension to let the server know the
client can handle spontaneous "deepen" commands and only activate new
mode when the extension is present?

> So what next? I think there's some protocol work here, and I think the
> overall design of that needs to be considered alongside the other
> "deepen" options your topic in pu adds (and of which I'm largely
> ignorant). Does this sufficiently interest you to pick up and roll into
> your other shallow work?

I can pick it up if you are busy with other stuff. But I'm also having
a couple other topics at the moment, so it may not progress very fast.
--
Duy

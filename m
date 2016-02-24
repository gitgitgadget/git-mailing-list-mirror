From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv15 2/5] run_processes_parallel: add LF when caller is sloppy
Date: Wed, 24 Feb 2016 13:59:25 -0800
Message-ID: <CAGZ79kZvD4zFA61XvSLa8fe1PzH91+4ii5vSeH-P+ER2wbQy2g@mail.gmail.com>
References: <1456284017-26141-1-git-send-email-sbeller@google.com>
	<1456284017-26141-3-git-send-email-sbeller@google.com>
	<20160224211947.GO28749@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 22:59:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYhT1-00021g-LT
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 22:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100AbcBXV71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 16:59:27 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:32872 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbcBXV70 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 16:59:26 -0500
Received: by mail-io0-f169.google.com with SMTP id z135so69286228iof.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 13:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=acxaLgJXNEfic5KL4J4pkkPcn98Pd6dExGDKc0D2iGo=;
        b=E1SvpROCIcaWZ+7VSZHLVq0y+bgwfG19oX4o0SH1GVHr3FulY7ZlZnn981YnPA+F6I
         nSO03dbE2NHlI72W0rpQzGVshflv+PVo27OecwOWlBjkQDf/MmYecnxcXvnOZOuGVaqH
         lqH+ohQs2DzTNXVOScJJBl7dYmHbUR4WnEAyRRDXYi6J456mnpctLg/YXe2a9PjOXNa/
         XHCor9pXCRvYIJw0MseW2C73+TrWDCwYYJSVKnJMOSCr931zQ3ov+9Ldz98OItMSH7Ui
         HYoCGYUQQXxrosdvfmtxuH6wv32Dk5vNdw65gZbCclromTb3EG9cbU33O3GQf92zSG6s
         fozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=acxaLgJXNEfic5KL4J4pkkPcn98Pd6dExGDKc0D2iGo=;
        b=b3aSnakbEiXOlbMeKSWJWv4WSOjtC6LdnW6gk4XOfmCCA11iSl1Qhm99M4ssbnItj1
         OXKbr8o8qGucFz9xrHVVGY6gaB/hACrM76Z92AD1zTAMOMmB9lyWSDDmSjxG1arF1xCk
         MhnOCaOt0gCgAaE1Fa7IvL4Basil+JqWg9OEVMPZy0299tzI8HGohv7XtpdPu2XzC4Sa
         LPIkvu1QcHW9csNwwsdGJ2s9PBJX63cpdwvA4JwDT9Ydj7r8ncSX13uqSnlYbZ5GU9C+
         fIC+FWlatLqXNSNhf3fdK34KnwE+Ld+dRqa8joemDA+Ii1n5B6XUBDkbSblQpH2r0FkU
         m2fw==
X-Gm-Message-State: AG10YOSHoweexnoCDREWcmscdPqdlJ4Pbo4+2P3fuoN4GzgIwoKNCsBoVrUezyltXF7+LAnYAMGjKkw4qXqbAt8Q
X-Received: by 10.107.158.138 with SMTP id h132mr21288556ioe.174.1456351165837;
 Wed, 24 Feb 2016 13:59:25 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Wed, 24 Feb 2016 13:59:25 -0800 (PST)
In-Reply-To: <20160224211947.GO28749@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287235>

On Wed, Feb 24, 2016 at 1:19 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Stefan Beller wrote:
>
>> When the callers of parallel processing machine are sloppy with their
>> messages, make sure the output is terminated with LF after one child
>> process is handled.
>
> Why not always add \n here?

So you propose to always add a \n if the output length was > 0 ?

>
> That would make callers simpler and would make it easier for callers to
> know what to do.  It also makes it possible to end with \n\n if the
> caller wants.

If the caller wants a \n\n it can do so as well using this patch?

If we add an \n unconditionally we run the risk of having lots of empty lines
in there. Consider the tests which are already there:

    test-run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\"
Hello World" >actual

would produce

cat >expect <<-EOF
preloaded output of a child
Hello
World

preloaded output of a child
Hello
World

preloaded output of a child
Hello
World

preloaded output of a child
Hello
World
EOF

as both the child as well as we added a \n, so one empty line was born.
And as most child processes actually terminate with a reasonable \n
after their output,
I would not want to add another \n because it is simpler or easier to predict.

Thanks,
Stefan


>
> Thanks,
> Jonathan

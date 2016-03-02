From: Stefan Beller <sbeller@google.com>
Subject: Re: Resumable git clone?
Date: Tue, 1 Mar 2016 17:40:28 -0800
Message-ID: <CAGZ79kYjuaOiTCC-NnZDQs=XGbgXWhJe7gk576jod4QnV57eEg@mail.gmail.com>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, sarah@thesharps.us,
	viro@zeniv.linux.org.uk
To: Josh Triplett <josh@joshtriplett.org>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 02:40:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aavmI-0001jg-G2
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 02:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313AbcCBBkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 20:40:32 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:35192 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbcCBBk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 20:40:29 -0500
Received: by mail-io0-f172.google.com with SMTP id g203so243882216iof.2
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 17:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=sIxE4lpem3lF6GDeDceIr++t+lbUFpw/kDyYTX7drAY=;
        b=hJGRMo6DEWefEUMDY9owxtlfZyCU0FZ0KWqglH4eLSkp8af2veNt/opZk6kQBzDZC8
         C6tKGIm4ZzzqE/NF85su5hRjWChxMX+OECIe+WDnBWosDzDAEa5rFADO8Jx+YJ1tGmcU
         iEqskaAWk0PCaYda5bADj6GcM6ZXDzdubJxIjL0SUa4ewX0g40A+G2zGU2dN8BAhm/Qs
         qtyofP748Pn5PtO4wMXrZRKldrZFij0BTZGFYsMJMcrpIToLmo666BU2qZrwNydTubsy
         BqCAdBbeVhfYMmDshbUiU3WUsVCvNwawcyqbrPS896hyOSDoVUG4It/NGWkLVlQ4mruZ
         erjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=sIxE4lpem3lF6GDeDceIr++t+lbUFpw/kDyYTX7drAY=;
        b=AbeFjbr3QwYC0mzT4fdcEQF0sGp7hTI7A8dlwKFDO/apVwCG2PUS6E/gy9i6b/YJLr
         dZMIeG2mZ1slnmRr7ViY51mYTJcwS0z0yWKTcfwaZKb/zUgoUu3UuXSTkURvRue9bZgK
         5oQTEeJ+QJPOlIQNxAGIeff4J//YBJL1BMCEQWhYW5p+b/v4a39nco2XYMXa3i2KZrjw
         9vtCzkC5rlZcqgXf0S6u6ynbnauEbkIucFVA1sOi8L2ZgSa7CuB3gGpQGM+YjZkkHaP+
         Wo93rsgtc4Zpe5f0+pzLBfd2rn44/VY5sH7MMgEKszRlmXYT3ROnmrIaZwZFLFFnKtjB
         BRsg==
X-Gm-Message-State: AG10YOQhJ9iLz/sHcM4x8A2kPw4zOjUA5fkFLVU0DUSdfASXWvYFJHaRbRwbYpNu1zC827eFlb0O8SrsOK66eh0o
X-Received: by 10.107.158.138 with SMTP id h132mr26711226ioe.174.1456882828836;
 Tue, 01 Mar 2016 17:40:28 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Tue, 1 Mar 2016 17:40:28 -0800 (PST)
In-Reply-To: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288089>

+ Duy, who tried resumable clone a few days/weeks ago

On Tue, Mar 1, 2016 at 5:30 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> If you clone a repository, and the connection drops, the next attempt
> will have to start from scratch.  This can add significant time and
> expense if you're on a low-bandwidth or metered connection trying to
> clone something like Linux.
>
> Would it be possible to make git clone resumable after a partial clone?
> (And, ideally, to make that the default?)
>
> In a discussion elsewhere, Al Viro suggested taking the partial pack
> received so far,

ok,

> repairing any truncation,

So throwing away half finished stuff while keeping the front load?

> indexing the objects it
> contains, and then re-running clone and not having to fetch those
> objects.

The pack is not deterministic for a given repository. When creating
the pack, you may encounter races between threads, such that the order
in a pack differs.

> This may also require extending receive-pack's protocol for
> determining objects the recipient already has, as the partial pack may
> not have a consistent set of reachable objects.
>
> Before starting down the path of developing patches for this, does the
> approach seem potentially reasonable?

I think that sounds reasonable on a high level, but I'd expect it blows up
in complexity as in the receive-pack's protocol or in the code for having
to handle partial stuff.

Thanks,
Stefan

>
> - Josh Triplett
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

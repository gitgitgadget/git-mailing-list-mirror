From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH try2 01/14] Add proper 'stage' command
Date: Mon, 14 Oct 2013 17:22:33 -0500
Message-ID: <525c6ea918b6a_235dd2be7837@nysa.notmuch>
References: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
 <1381561488-20294-6-git-send-email-felipe.contreras@gmail.com>
 <CAPig+cQN5e8hOKTvHRKUQoLmctUWbAqTydgfY10Kr4AzHtB7kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 00:28:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVqdG-0002fE-Cc
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 00:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757800Ab3JNW2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 18:28:53 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:43304 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757771Ab3JNW2u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 18:28:50 -0400
Received: by mail-oa0-f48.google.com with SMTP id m6so5015937oag.21
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 15:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=9S7mSKiBOj2W/kY8ykK9/p1hedSNFcTjrlOKR2qNgHg=;
        b=qdBD9vLlzgSTwnqYk9BaGj9PkKYLQENsgGzdm2iOA38gZLgF6c69VBqz8OvND3aTAa
         g4i5+6u0KywAH+dTBc3hSywSqb9A8A+v115rjY8WQ9ZtzlJJeGE7P3S6E68xSvQ7HE7S
         TvEAqZAE5Uw8tqk9x9d573Byoxs3/Ugod8JjnZLWIg+i23FnVZpIgvjhKCTgHZhiKI++
         S4pr2Xwv5J3Y/pivt8XQp88HJFmXOIL6ViNOoTgRItfm5c7t5mPo8nVwEy33IhLImf6Q
         UueEA+cPRZDDacRRnwKjGLGeOSeQKQOPlMXeycuZiQeuoltOFgWs+bJ7anq4+4AI5g3G
         PVFQ==
X-Received: by 10.182.48.130 with SMTP id l2mr3521558obn.44.1381789730420;
        Mon, 14 Oct 2013 15:28:50 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id m7sm6020790obo.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Oct 2013 15:28:49 -0700 (PDT)
In-Reply-To: <CAPig+cQN5e8hOKTvHRKUQoLmctUWbAqTydgfY10Kr4AzHtB7kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236125>

Eric Sunshine wrote:
> On Sat, Oct 12, 2013 at 3:04 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git stage' args...
> > -
> > +'git stage' [options] [--] [<paths>...]
> > +'git stage add' [options] [--] [<paths>...]
> > +'git stage reset' [-q|--patch] [--] [<paths>...]
> > +'git stage diff' [options] [<commit>] [--] [<paths>...]
> > +'git stage rm' [options] [--] [<paths>...]
> > +'git stage apply' [options] [--] [<paths>...]
> >
> > diff --git a/builtin/stage.c b/builtin/stage.c
> > new file mode 100644
> > index 0000000..3023d17
> > --- /dev/null
> > +++ b/builtin/stage.c
> > @@ -0,0 +1,52 @@
> > +/*
> > + * 'git stage' builtin command
> > + *
> > + * Copyright (C) 2013 Felipe Contreras
> > + */
> > +
> > +#include "builtin.h"
> > +#include "parse-options.h"
> > +
> > +static const char *const stage_usage[] = {
> > +       N_("git stage [options] [--] <paths>..."),
> > +       N_("git stage add [options] [--] <paths>..."),
> > +       N_("git stage reset [-q|--patch] [--] <paths>..."),
> > +       N_("git stage diff [options] [<commit]> [--] <paths>..."),
> > +       N_("git stage rm [options] [--] <paths>..."),
> > +       NULL
> > +};
> 
> Missing usage for "git stage apply".

Right. Will add

-- 
Felipe Contreras

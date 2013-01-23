From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3 2/8] git_remote_helpers: fix input when running under
 Python 3
Date: Wed, 23 Jan 2013 11:20:39 -0800
Message-ID: <CAGdFq_jp3BrS0zgDpmiXGduwu_m4E2CCL+X32P-7T=z9Qk-wuQ@mail.gmail.com>
References: <cover.1358686905.git.john@keeping.me.uk> <7cd489e5b1b2578b1509232196cd6b21fd684843.1358686905.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 23 20:21:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty5tG-0005gF-Fo
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 20:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650Ab3AWTVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 14:21:21 -0500
Received: from mail-qc0-f176.google.com ([209.85.216.176]:44881 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab3AWTVU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 14:21:20 -0500
Received: by mail-qc0-f176.google.com with SMTP id n41so5181080qco.7
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 11:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=LdMJIAqkrrNAntn03GirLVz0y+/JuWliWJLW67FDQAw=;
        b=afafSoAyjjRDgdspzfXFXdCinKRyCWDcud37eXauLu7vpk4B9uytXgOCmuKj7VOqwV
         3TfkI4LQqaqTvmGDaSEFs0ZINPnCQMGVZUHNVhWtqG+q+QWoCoZF+RZm49h91nCYY2zv
         +8gDAnzf+BAn4Nwkk8I/x9KalckinHHwrT4urwt7m21CKygCKVjDiCKMxpQoGtWZYjIY
         BxzzPw0z7x+SuPBnYMLtlDKPsoqyMhPuJNbnp/rYrllifKxCDBPQTxBNUT0oQGLcfzJp
         KuUxpA1gtQ7T0pDMdoEWV1NX1CS11AHzi7BHY4a9Yvxb3YxSJ9toH3RPa0WiYQvynwua
         adBA==
X-Received: by 10.49.130.167 with SMTP id of7mr3056816qeb.22.1358968879467;
 Wed, 23 Jan 2013 11:21:19 -0800 (PST)
Received: by 10.49.51.227 with HTTP; Wed, 23 Jan 2013 11:20:39 -0800 (PST)
In-Reply-To: <7cd489e5b1b2578b1509232196cd6b21fd684843.1358686905.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214346>

On Sun, Jan 20, 2013 at 5:15 AM, John Keeping <john@keeping.me.uk> wrote:
> Although 2to3 will fix most issues in Python 2 code to make it run under
> Python 3, it does not handle the new strict separation between byte
> strings and unicode strings.  There is one instance in
> git_remote_helpers where we are caught by this, which is when reading
> refs from "git for-each-ref".
>
> Fix this by operating on the returned string as a byte string rather
> than a unicode string.  As this method is currently only used internally
> by the class this does not affect code anywhere else.
>
> Note that we cannot use byte strings in the source as the 'b' prefix is
> not supported before Python 2.7 so in order to maintain compatibility
> with the maximum range of Python versions we use an explicit call to
> encode().

The three patches that deal with .encode() stuff (2, 7, 8) make me a
bit uncomfortable, as they add some significant complexity to our
python code. Is this the recommended way to deal with this (similar to
the other patch where you linked to the python wiki explaining)?

As one datapoint, it seems that it's actually Python 2.6 that
introduces the b prefix.

http://www.python.org/dev/peps/pep-3112/

When did we last revisit what minimal python version we are ok with requiring?

--
Cheers,

Sverre Rabbelier

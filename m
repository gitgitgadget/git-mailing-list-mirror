From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 41/44] refs.c: add a new flag for transaction delete
 for refs we know are packed only
Date: Thu, 22 May 2014 12:12:42 -0700
Message-ID: <CAL=YDWkUa2Ut=1iaMXgnjgte6g5jvXR49LBiEUNEkwv4Z-wO_w@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-42-git-send-email-sahlberg@google.com>
	<20140522181722.GT12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 21:12:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnYQ3-0004ez-Eh
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 21:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbaEVTMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 15:12:44 -0400
Received: from mail-vc0-f182.google.com ([209.85.220.182]:41689 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbaEVTMn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 15:12:43 -0400
Received: by mail-vc0-f182.google.com with SMTP id la4so4976552vcb.41
        for <git@vger.kernel.org>; Thu, 22 May 2014 12:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RMSZkH6irr8GRzq2h9xBMkfKtHgC0bfJxawHWKPtcHc=;
        b=XpXaGnednOGuC9VY0FBtVdoLd4uBlsxdGxCevT0OeEBkLv2ZxrQz9QfZyHrMY2Rm/N
         tFCSXmC8zrIWhkGvDE0zEpoKrAuaRM3nH8H8uM/8lG0N7LW6zbaT36jfNQI8jyA0NQfe
         V/SxuIuH4NbJQ8hWJwi95Blbl7KTMImP1/uG9QXF6z9UDC+Zq6wX+Y2RztMetv0jpNIm
         gm9slaO6pbCLDzGCw9TYsk19LIVjOKyEUxCfy28a4Q6FTpd7eFCdMjQcuP5ooD7Qa+6c
         8Burczx1CoZnedlOjNLPyElacEpISqbAXEy/uBf7QNyVbq1rECO9WU56KOrLl1zaWatU
         1sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=RMSZkH6irr8GRzq2h9xBMkfKtHgC0bfJxawHWKPtcHc=;
        b=L+63TDzPNtAfqNwKgfCe1D/S5T5y+pHdNWKIAsDoo6US9fISj8fviI0790N3Imp1uf
         UFVwShQ4MKFuh8BrFbVGkWKbXCK1Jlh8YCnl/6Ph4fPMxbIiHTCEbasfF3lPRbiRjwdH
         zg7GT88YMBhHbqLaC9kFnrwg1NdPC7PgRTqRwyyhucwd17gQSwPlwGPt6Ai5i0LmWp0X
         rW16aUOiFs2laJ3q7y3LbJCgMgmGcHp1qoRod6mOiEmo4J7g5TLl/VVZNA7EiYzPZeSp
         DWoGwzgEhnbDXHVK1bW3RMVhD41gNf3SgJ4fUk+U8DFm+Ux5pO/CY68mu/6iGfbXEeo9
         87+Q==
X-Gm-Message-State: ALoCoQmPUHSshv/9ve9t+/m3tXXNQmQy4QlpNjHsjVIwJ0oe1co2klL/itOBho2ewCC4f96qFkcP
X-Received: by 10.58.89.242 with SMTP id br18mr48512veb.66.1400785962568; Thu,
 22 May 2014 12:12:42 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 22 May 2014 12:12:42 -0700 (PDT)
In-Reply-To: <20140522181722.GT12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249936>

On Thu, May 22, 2014 at 11:17 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Ronnie Sahlberg wrote:
>
>> Add a new flag REF_ISPACKONLY that we can use in ref_transaction_delete.
>> This flag indicates that the ref does not exist as a loose ref andf only as
>> a packed ref. If this is the case we then change the commit code so that
>> we skip taking out a lock file and we skip calling delete_ref_loose.
>
> This seems wrong.  Can't someone else create a loose ref which will
> shadow the packed ref and break the serializability of updates to this
> ref?
>
> The above doesn't explain why we want to avoid locking the loose ref,
> but I assume it's for the sake of the "git branch -m foo/bar foo"
> case.  For that case, wouldn't the following sequence of filesystem
> operations work?
>
>         - create $GIT_DIR/refs/heads/foo/bar.lock
>         - create $GIT_DIR/refs/heads/foo.lock
>         - if $GIT_DIR/refs/heads/foo/bar exists, add the ref to
>           packed-refs (using the usual lockfile-update mechanism)
>           and unlink $GIT_DIR/refs/heads/foo/bar
>         - verify that current foo and foo/bar state are okay.  If
>           not, roll back.
>         - unlink $GIT_DIR/refs/heads/foo/bar.lock
>         - rmdir $GIT_DIR/refs/heads/foo
>         - rename $GIT_DIR/refs/heads/foo.lock into place
>
> Or:
>
>         - create $GIT_DIR/refs/heads/foo/bar.lock
>         - create $GIT_DIR/refs/heads/foo.lock
>         - verify state of all relevant refs
>
>         - update packed-refs to remove refs/heads/foo/bar and
>           add refs/heads/foo
>
>         - unlink $GIT_DIR/refs/heads/foo/bar
>         - unlink $GIT_DIR/refs/heads/foo
>         - unlink $GIT_DIR/refs/heads/foo/bar.lock
>         - unlink $GIT_DIR/refs/heads/foo.lock
>


I removed all the rename_ref related patches for now. rename_ref is
probably best implemented specifically for each backend anyway.

I will still produce a separate patch that will do something like this
you suggested
(since rename_ref is still racy and fragile)

>         - create $GIT_DIR/refs/heads/foo/bar.lock
>         - create $GIT_DIR/refs/heads/foo.lock
>         - verify state of all relevant refs
>
>         - update packed-refs to remove refs/heads/foo/bar and
>           add refs/heads/foo
>
>         - unlink $GIT_DIR/refs/heads/foo/bar
>         - unlink $GIT_DIR/refs/heads/foo
>         - unlink $GIT_DIR/refs/heads/foo/bar.lock
>         - unlink $GIT_DIR/refs/heads/foo.lock
>

Thanks
ronnie sahlberg

From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Sun, 11 Aug 2013 18:09:15 -0500
Organization: Exigence
Message-ID: <20130811180915.390d660a@sh9>
References: <1376256387-30974-1-git-send-email-stephen@exigencecorp.com>
	<CAPrKj1b=QTdqVH+JtukJrfEc=EqxWOEYE4YG7oSY7413uqdKfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andres Perera <andres.p@zoho.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 01:09:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8elQ-0005cx-BI
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 01:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049Ab3HKXJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Aug 2013 19:09:19 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:48037 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab3HKXJS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Aug 2013 19:09:18 -0400
Received: by mail-oa0-f49.google.com with SMTP id n10so3680278oag.36
        for <git@vger.kernel.org>; Sun, 11 Aug 2013 16:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exigencecorp.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-type:content-transfer-encoding;
        bh=4fMbhNidmMULw2TOP+eGivn4PKATcf6cJP11fu9e1Wk=;
        b=b9H8meebAptl4Lb36/zXWDOFUJ4QlUMvFvjprGBjRUvZdrwsZSDRd3820Obnd5ZpJ2
         wpykRHtHyRGBuMQX2T2BpbHD53FkBb2L61pLYKnhbcaieOEOx/unNGSC3mwbDOnf4B36
         BvCXeJPlikBIIwlyAsHBOgk/dTwDLMySKe2Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-type
         :content-transfer-encoding;
        bh=4fMbhNidmMULw2TOP+eGivn4PKATcf6cJP11fu9e1Wk=;
        b=Rq4WjRuBcPOefJX5S1CyNlCpHdCSYRM83c37l7eFz6POCd/As1sh/s6WGdqH8v3+O1
         fOy9CsQgmjw9ad1IlCC4lON3KnzJFUMlrii4GprnQiTmGRUu1FoVXOdU4U/G3tAgY5Gd
         JwVUuu50GTzBzaJiOqSTbEaS/AKXQREo+pQV8nxb7dPTmQv95mqMa202mZxYde+ILxFy
         u0gk9sufQbpZUTw9tO5H/L10WJfpfiiWsICfDsHL6TDlB5RTSJMzRE2i9iILqsA7afFQ
         /32XMBB905o2xoKHE0dPRenyvndF1CRADXDIMABBsKmRNZcVg6At6xaDY17ywWJSK3Lv
         +fZA==
X-Gm-Message-State: ALoCoQlmjfXrGtzM3kLjUub5oEB5JxumwNp8XcsZsbqbRnb0faiM0pE6GDS/gZR6O1eEaK/xbiqf
X-Received: by 10.60.42.168 with SMTP id p8mr8558433oel.73.1376262557916;
        Sun, 11 Aug 2013 16:09:17 -0700 (PDT)
Received: from sh9 (wsip-184-187-11-226.om.om.cox.net. [184.187.11.226])
        by mx.google.com with ESMTPSA id cp7sm30551955obb.0.2013.08.11.16.09.16
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Sun, 11 Aug 2013 16:09:17 -0700 (PDT)
In-Reply-To: <CAPrKj1b=QTdqVH+JtukJrfEc=EqxWOEYE4YG7oSY7413uqdKfg@mail.gmail.com>
X-Mailer: Claws Mail 3.9.1 (GTK+ 2.24.17; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232143>


> 1. i'm not sure why you are testing $3 == preserve. it looks like a
> typo

Yes, good catch. I've added a test that fails, and will fix that.

> 2. clearer than a string of yoda conditions:
> 
> case $2 in
> true|false|preserve)

Makes sense, will change.

> 1. in the error message you say that rebase should be a trystate of
> true, false, or preserve. why then do you allow $rebase == '' ?

Because it may be unset, like if the user ran "git pull . copy" and
the pull.rebase setting was not set.

> 2. clearer than a string of yoda conditions:

Will change again.

I'll wait to see if I get any more feedback and then will send out
another version.

Thanks!

- Stephen

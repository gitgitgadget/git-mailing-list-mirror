From: David Turner <dturner@twopensource.com>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Tue, 23 Jun 2015 17:35:01 -0400
Organization: Twitter
Message-ID: <1435095301.28466.76.camel@twopensource.com>
References: <1435020656.28466.8.camel@twopensource.com>
	 <55898073.4010105@alum.mit.edu>
	 <1435089205.28466.56.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 23 23:35:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7VqX-0006vG-GL
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 23:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbbFWVfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 17:35:05 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33234 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936AbbFWVfE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 17:35:04 -0400
Received: by qkhu186 with SMTP id u186so12201116qkh.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 14:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=+JWOHqAXUv0mWwYVpUKARJqbrM6NkRFaiFkQ0gwohbI=;
        b=Zm4hk9/MZjyDWxjuoNYrj/vByXqic5LaM0G7BLrcq+Xo073a3EtS6mC0jPuQ9uDh1p
         9YCfAH6TRdnfKIk/3pQdDTkY5N8iZCQQccbhlDWZ64YFyXH/Sw37DYrfj7AOWxYkF4+H
         umHE8qZPpRV0BkqrGHlbaZ14zPtPK0C92JUye/LZiOX5QgyE3/z4c4P14eO/G14u8XT6
         xJBXJ1xQ39w5tSZfhUBOQ4jA3FIWUzD+vJZsx4aYTu6ngikdhW+j4YltvvsU+zleKop2
         uLoO86o21VJ+vQcY6n7RLDHFKSy9D3Px2ehptZjSh0JECn+xdeFgpU++YYJXzHez2u79
         gRIQ==
X-Gm-Message-State: ALoCoQmHGE9/GbCrkg50YMUqZOAFfQFYY+ge31VHd0Euhyzqd6iF0KDNT9CaBs8EleQHq9dFZ3Q8
X-Received: by 10.140.100.162 with SMTP id s31mr46709716qge.36.1435095303226;
        Tue, 23 Jun 2015 14:35:03 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by mx.google.com with ESMTPSA id 68sm2140008qgk.9.2015.06.23.14.35.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2015 14:35:02 -0700 (PDT)
In-Reply-To: <1435089205.28466.56.camel@twopensource.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272521>

On Tue, 2015-06-23 at 15:53 -0400, David Turner wrote:
> > * Regarding MERGE_HEAD: you take the point of view that it must continue
> > to be stored as a file. And yet it must also behave somewhat like a
> > reference; for example, `git rev-parse MERGE_HEAD` works today.
> > MERGE_HEAD is also used for reachability, right?
> > 
> > Another point of view is that MERGE_HEAD is a plain old boring
> > reference, but there is some other metadata related to it that the refs
> > backend has to store. The file-based backend would have special-case
> > code to read the additional data from the tail of the loose refs file
> > (and be sure to write the metadata when writing the reference), but
> > other backends could store the reference with the rest but do their own
> > thing with the metadata. So I guess I'm wondering whether the refs API
> > needs a MERGE_HEAD-specific way to read and write MERGE_HEAD along with
> > its metadata.
> 
> You are probably right that this is a good idea.

On reflection, I think it might make sense to keep MERGE_HEAD as a file.
The problem is that not only would refs backends have to add new
MERGE_HEAD-handling functions, but we would also need new plumbing
commands to allow scripts to access the complete contents of MERGE_HEAD.
That seems more complicated to me.  

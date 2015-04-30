From: David Turner <dturner@twopensource.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Wed, 29 Apr 2015 18:45:45 -0700
Organization: Twitter
Message-ID: <1430358345.14907.62.camel@ubuntu>
References: <1430341032.14907.9.camel@ubuntu>
	 <xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
	 <1430343059.14907.18.camel@ubuntu> <20150429214817.GA2725@peff.net>
	 <1430346576.14907.40.camel@ubuntu> <20150429231150.GB3887@peff.net>
	 <20150430003750.GA4258@peff.net> <1430355983.14907.55.camel@ubuntu>
	 <20150430011612.GA7530@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 03:45:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YndY2-0000OQ-CH
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 03:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbbD3Bpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 21:45:50 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36664 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbbD3Bpt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 21:45:49 -0400
Received: by pabsx10 with SMTP id sx10so44272154pab.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 18:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=7ZSwANivNVYc9mmlK281caq7F7UhTVF7pJqY2dHIQdU=;
        b=AX+bt/8AvKdBi+hC6mcyP8Ppz7u0mwt8tjQjD6MpVpg7tpPqq9HfwvUAkE4zRcaoyj
         wrbMw8z1WjZgnQGDidtob60zhZQrQqlocpt3LNWPDPAI3cG94m3k8LzZD+wXs1oJNTdx
         t6sLIqLD3tr1PcNcuLC14RqZMwnnmqTclb/UG30H68Iqagw+BwwRgnGEYgbpQlwZ7PqN
         ctntK5MDjM3o99EwxhtOSzNX+HpXyFTYqEmFpvbCzmiE0kPm/U22H1wKL/WCrF5Cl4P4
         jLtf8M9hixdDSXIKOvBDRSiSmFaNam8eE7WFoqvjq7ua9EF6k2yBS8RRL3qRNTbEWn6P
         z/yg==
X-Gm-Message-State: ALoCoQkE6y0Z0t9X/A3mIsEza7uWfUI/JMJEvblJikmAKbWv+1zhjQn5YvHx3X/PH4pPlc+ZBNKY
X-Received: by 10.68.219.42 with SMTP id pl10mr3550621pbc.154.1430358348758;
        Wed, 29 Apr 2015 18:45:48 -0700 (PDT)
Received: from [172.25.135.195] ([8.25.197.26])
        by mx.google.com with ESMTPSA id f1sm427587pds.62.2015.04.29.18.45.46
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2015 18:45:47 -0700 (PDT)
In-Reply-To: <20150430011612.GA7530@peff.net>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268050>

On Wed, 2015-04-29 at 21:16 -0400, Jeff King wrote:
> On Wed, Apr 29, 2015 at 06:06:23PM -0700, David Turner wrote:
>   3. Ditto for out-of-tree. Note that this would be the _raw_ symlink
>      contents, not any kind of simplification (so if you asked for
>      "foo/bar/baz" and it was "../../../../out", you would the full path
>      with all those dots, not a simplified "../out", which I think is
>      what you were trying to show in earlier examples).

Unfortunately, we need the simplified version, because we otherwise
don't know what the ..s are relative to in the case of a link to a link:

  echo content >dest ;# actual blob
  mkdir -p foo/bar
  ln -s foo/bar/baz fleem             # in-tree link-to-link 
  ln -s ../../../external foo/bar/baz # out-of-tree link

If echo HEAD^{resolve}:fleem were to return ../../../external (after
following the first symlink to the second), we would have lost
information.

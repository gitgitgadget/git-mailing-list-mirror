From: Mike Hommey <mh@glandium.org>
Subject: Re: parse_object does check_sha1_signature but not
 parse_object_buffer?
Date: Tue, 2 Feb 2016 11:06:11 +0900
Message-ID: <20160202020611.GA30613@glandium.org>
References: <20160202015701.GA30444@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 03:06:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQQMH-00057p-Nu
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 03:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbcBBCGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 21:06:18 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:35162 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbcBBCGR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 21:06:17 -0500
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <mh@glandium.org>)
	id 1aQQM7-0008Jy-V6
	for git@vger.kernel.org; Tue, 02 Feb 2016 11:06:11 +0900
Content-Disposition: inline
In-Reply-To: <20160202015701.GA30444@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285232>

On Tue, Feb 02, 2016 at 10:57:01AM +0900, Mike Hommey wrote:
> Hi,
> 
> You might or might not be aware of this thread:
> https://groups.google.com/forum/#!topic/binary-transparency/f-BI4o8HZW0
> 
> Anyways, this got me to take a look around, and I noticed that
> parse_object does SHA-1 validation through check_sha1_signature. What
> surprised me is that parse_object_buffer doesn't. So we end up with
> inconsistent behavior across commands:
> 
> $ git init
> $ echo a > a ; echo b > b
> $ git add a b
> $ git cat-file blob 78981922613b2afb6025042ff6bd878ac1994e85
> a
> $ cp -f .git/objects/61/780798228d17af2d34fce4cfbdf35556832472 .git/objects/78/981922613b2afb6025042ff6bd878ac1994e85
> $ git cat-file blob 78981922613b2afb6025042ff6bd878ac1994e85
> b
> $ git show 78981922613b2afb6025042ff6bd878ac1994e85
> error: sha1 mismatch 78981922613b2afb6025042ff6bd878ac1994e85
> fatal: bad object 78981922613b2afb6025042ff6bd878ac1994e85
> 
> Shouldn't parse_object_buffer also do check_sha1_signature?

Well, except cat-file doesn't use parse_object_buffer either...

Mike

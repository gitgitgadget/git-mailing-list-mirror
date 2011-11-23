From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Possible bug with branch names and case sensitivity
Date: Wed, 23 Nov 2011 09:54:45 +0100
Message-ID: <4ECCB4D5.3090200@alum.mit.edu>
References: <D144F6C9-C6A3-4516-BC88-B9EB50890EF4@bitart.com>	<CAG+J_Dz6nK5fPhBRmoojmgYSv5OviN7pfgNKnRy9_9WmDS1_2w@mail.gmail.com>	<4ECB315F.4080701@alum.mit.edu> <CAG+J_DxREbykWggrD49L7qvR9M36wKL7+_kOYbvcWmLBCF2Gog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Gerd Knops <gerti@bitart.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 09:55:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RT8bc-0005B1-2T
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 09:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758831Ab1KWIy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 03:54:56 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:51329 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755451Ab1KWIy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 03:54:56 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pAN8sjYm028205
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Nov 2011 09:54:46 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <CAG+J_DxREbykWggrD49L7qvR9M36wKL7+_kOYbvcWmLBCF2Gog@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185829>

On 11/22/2011 06:31 PM, Jay Soffian wrote:
> I wonder what the downside would be of always using packed refs on
> case-insenstive file systems. This would seem analogous to how git no
> longer uses symlinks.

The theoretical downside is that when the total number of packed refs is
very large, it is more expensive to access or change a single ref if it
is packed than if it is loose (because the whole packed refs file has to
be read, parsed, then rewritten, and thus scales like O(N)).  OTOH the
number of references must be quite large before loose references win,
because the constant factor for loose references is much larger than
that for packed references.  I also believe that there is still scope
for optimizing the handling of packed references to make them yet faster
and perhaps even improve their scaling.

But I think that a lot of code would have to change to make this happen.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

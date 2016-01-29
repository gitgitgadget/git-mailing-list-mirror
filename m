From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] attempt connects in parallel for IPv6-capable builds
Date: Fri, 29 Jan 2016 07:08:02 +0100
Message-ID: <56AB01C2.3090803@web.de>
References: <20160128115720.GA1827@dcvr.yhbt.net>
 <xmqqtwlxjdbx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jan 29 07:08:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aP2Ej-0007PA-7a
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 07:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbcA2GIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 01:08:46 -0500
Received: from mout.web.de ([212.227.17.11]:52870 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352AbcA2GIa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 01:08:30 -0500
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0LlF9O-1ZqWxL1KY2-00b248; Fri, 29 Jan 2016 07:08:09
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <xmqqtwlxjdbx.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:8WARxes/YxZ70avaY2+HAX6bDwhRS9khKM2Cj+DgKx9iD/RNdmD
 JFwMkd8udttjrSktKnWj4alTJOUryR88bFSDZSwlMaDGGwM38fDfKAfSOTuLX5ZsuX7jBxT
 sTMlg1QBHx+HuR1dH833mVoiZ15+WeAkFV4CYPQfXVSs8/m+6HlqwxqO1hZqHBUjqKxJ/w6
 jobQdredn8soU0snkhKAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wc+aIgGBh3o=:W5cABd3yjI/QHGqAR0pRLs
 5+NLcZWLROKDoFMeRITja+adZfrOVljANp0VBIpiDbRRi6W/b+ONQ9BBcJG92W5vXhHvFcFie
 9V81mB1pSOFyqnilzwdlRKeYakKd6hmeSo2E4R46b6BpImmX0dHNsxZSM8i4YQcMonCCT5VCr
 KOqOJS6xbcF0NjLvgOtv+SYpxch5W3aAAK1+H2/OBsXdj+O5xIU79xtje91sP4SNz1dHp9uzB
 rlyZGkyT3VLovbs2hMrURjB8fHmP6EsInHqc1vaMLqL5bFrkxIiRwJJ5qQ9yJqaE5rCsaPXQa
 BVu/zwxcMo0sz0CSnsYXb/16CLXs/EaDWphcL5GMRFAcyf8wKQ1dusRhJKbfeMR1CZxjVErQ5
 TVuKfdYQpifEJVf7Fy8jvYV8y8Hsg/LuSXPKydhHcRhtoUydrO+g8ITcLVXC26lqQWWOkTE4s
 7bvfIfKENIy2qxcx6sJ0SAJdZVSVKgDDj1uf/eZVWJWY2KkqpWqvOqTZ/0YjIebXaww7gGlPb
 8b2Wa3LBmbZnmujyVWkzllwcO6zK+Oz5kyFpVtH3Y4Lgyc0W1BmxCXlc3FJPxwIfDuHrrRCY4
 rsid5lrdFt6lWFbSF2swpieDBtyJLRbO8bxQSlC2GlhB3qwqdQP0Qi1i6QTayoTlJCQ5X//FJ
 HwLbOYYS17YyMlWrT0WQhBkKaeX3JgL7aM7XvHEwOuDd5/Q4SrFpUyub50Af3Y+SLjxVMITwp
 FBolt/XhkJWfE7TG2r+/LtYGzqbCB7y/xSk/jFVUZkvTYNr6iMzAxgaZG96zxW2I+CuLedB/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285062>

On 2016-01-29 04.04, Junio C Hamano wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
>> getaddrinfo() may return multiple addresses, not all of which
>> are equally performant.  In some cases, a user behind a non-IPv6
>> capable network may get an IPv6 address which stalls connect().
> 
> I'd assume that you are not solving a hypothetical problem, but you
> may (at least sometimes) have to reach outside world from such a
> network environment.  I further assume that git_tcp_connect() is not
> the only activity you do from such a network, and other network
> activities are similarly affected.
> 
> How do you work around the same issue for connections that do not go
> through git_tcp_connect()?  The same issue would affect Git traffic
> going over git-remote-curl, and also your usual Web browser traffic,
> no?
> 
> What I am getting at is if it is saner to solve the issue like how
> curl(1) solves it with its -4/-6 command line options, e.g. by
> adding a pair of configuration variables "net.ipv[46] = true/false".

(Please don't do parallel connects as a default)

I like the -4 / -6

Out of my head these kind of setups are not desired.
(getaddrinfo returns an address and the the following connect fails)
But it may be hard to fully avoid them in practice,
and some RFC have been written,  this may be a starting point:

https://www.rfc-editor.org/rfc/rfc5014.txt

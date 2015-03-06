From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 0/5] Retry if fdopen() fails due to ENOMEM
Date: Fri, 06 Mar 2015 06:08:46 +0100
Message-ID: <54F9365E.2000705@web.de>
References: <1425571669-22800-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 06:09:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTkVf-0005XN-8I
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 06:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbbCFFJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 00:09:11 -0500
Received: from mout.web.de ([212.227.15.14]:63001 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138AbbCFFJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 00:09:09 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0M0w07-1XcKyc2gTn-00v7Kq; Fri, 06 Mar 2015 06:09:05
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <1425571669-22800-1-git-send-email-mhagger@alum.mit.edu>
X-Provags-ID: V03:K0:LSs4TKDyeJ07n1JLirtv6OXsKf/vVRjyAeBI8VjZtfrjQ2AzzGV
 ZwkSshPhjvXF9fUek9Uk7wcMnem4OlYL+0gGNsykq555+3PpGoqldNpQxpgqKBz9CM/x4z8
 5MaP98Pw+huXrjcmFi+hyRTVOSg5d9LuiVIKsB6c8gIBRbNn7vD866rdIecTkWmnUiZ9hlA
 dSnP/SdiNT0Nr9Hz0XA/A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264889>

On 03/05/2015 05:07 PM, Michael Haggerty wrote:
> One likely reason for fdopen() to fail is the lack of memory for
> allocating a FILE structure. When that happens, try freeing some
> memory and calling fdopen() again in the hope that it will work the
> second time.
>
> This change was suggested by Jonathan Nieder [1]
>
> In the first patch it is unsatisfying that try_to_free_routine() is
> called with a magic number (1000) rather than sizeof(FILE). But the C
> standard doesn't guarantee that FILE is a complete type, so I can't
> think of a better approach. Suggestions, anybody?
>
>
it's not the sizeof(FILE) which is critical, it is the size of the buffer
associated with a FILE

http://pubs.opengroup.org/onlinepubs/009695399/basedefs/stdio.h.html

BUFSIZ may be  your friend, and if it is not defined, 4096 may be a 
useful default.

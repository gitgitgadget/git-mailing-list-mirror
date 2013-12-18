From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/3] prune-packed: fix a possible buffer overflow
Date: Wed, 18 Dec 2013 23:44:58 +0100
Message-ID: <52B2256A.3060802@alum.mit.edu>
References: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu> <1387287838-25779-2-git-send-email-mhagger@alum.mit.edu> <CACsJy8DVc4soBrS1RbTLv93b5rere3htyL1DjRw=UcT4zVN9FA@mail.gmail.com> <xmqqd2kvmi85.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 23:45:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtPrg-00079c-Gn
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 23:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391Ab3LRWpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 17:45:09 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:54259 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752329Ab3LRWpF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Dec 2013 17:45:05 -0500
X-AuditID: 1207440e-b7fbc6d000004ad9-2d-52b2256f421f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 23.E8.19161.F6522B25; Wed, 18 Dec 2013 17:45:03 -0500 (EST)
Received: from [192.168.69.148] (p57A24A3C.dip0.t-ipconnect.de [87.162.74.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rBIMj0Ha016463
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 18 Dec 2013 17:45:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131005 Icedove/17.0.9
In-Reply-To: <xmqqd2kvmi85.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsUixO6iqJuvuinIoOmzhcWvs7tYLLqudDNZ
	NPReYbbonvKW0eJHSw+zA6vHzll32T2e9e5h9Lh4Sdnj8ya5AJYobpukxJKy4Mz0PH27BO6M
	a9f/sRRM46pobLrB3MA4k6OLkZNDQsBEYt25HWwQtpjEhXvrgWwuDiGBy4wSr1Z/gnLOMUnM
	6p7MDFLFK6AtsWNrEyOIzSKgKnHh2gMmEJtNQFdiUU8zmC0qECTx6NBDdoh6QYmTM5+wgNgi
	AmoSE9sOsYAMZRaYwiix/MNjsEHCAq4SH5bvYILY9pFRYuvFCWDbOAWsJdYv7APq4AC6T1yi
	pzEIJMwsoCPxru8BM4QtL7H97RzmCYyCs5Dsm4WkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WL
	kxPz8lKLdI31cjNL9FJTSjcxQoKebwdj+3qZQ4wCHIxKPLwrXm4MEmJNLCuuzD3EKMnBpCTK
	e1h+U5AQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd4rLEA53pTEyqrUonyYlDQHi5I4r9oSdT8h
	gfTEktTs1NSC1CKYrAwHh5IEb4wKUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8
	KIrji4FxDJLiAdprC9LOW1yQmAsUhWg9xajLMe/Lh2+MQix5+XmpUuK8ciBFAiBFGaV5cCtg
	Ke4VozjQx8K8DiBVPMD0CDfpFdASJqAlz9esA1lSkoiQkmpgFGn4s3Bp7yXPzLfcx/cv2uNf
	MqPNeMXVWhGx4wu65d+XHptw3bCkqmPCZCWdAlGd1KN+tTouSnbsOufqFX1Ueu88 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239497>

On 12/17/2013 07:43 PM, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
>> Why don't we take this opportunity to replace that array with a
>> strbuf? The conversion looks simple with this function.
> 
> Indeed.  Something like this, perhaps?
> [...]

Frankly, with my initial patches I was just trying to paper over the bug
with the smallest possible change.  It's nice that people are attempting
bigger improvements.

I went in a slightly different direction: I am spiking out an API for
iterating over loose object files.  It would be useful in a couple of
places.

[While doing so, I got sidetracked by the question: what happens if a
prune process deletes the "objects/XX" directory just the same moment
that another process is trying to write an object into that directory?
I think the relevant function is sha1_file.c:create_tmpfile().  It looks
like there is a nonzero but very small race window that could result in
a spurious "unable to create temporary file" error, but even then I
don't think there would be any corruption or anything.]

But don't let me stop you; the cleanups you are working on are
definitely nice and are complementary to my ideas.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

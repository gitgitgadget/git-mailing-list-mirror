From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Pack files, standards compliance, and efficiency
Date: Fri, 05 Jun 2015 22:03:27 +0200
Message-ID: <5572008F.6030203@alum.mit.edu>
References: <20150605014120.GE305479@vauxhall.crustytoothpaste.net> <20150605094545.GB11855@peff.net> <5571BEA0.2080305@alum.mit.edu> <20150605194200.GB356121@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 22:03:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0xqE-0004bw-1j
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 22:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbbFEUDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 16:03:42 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:56145 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751443AbbFEUDl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2015 16:03:41 -0400
X-AuditID: 1207440d-f79026d000000bad-9b-557200910619
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 8C.86.02989.19002755; Fri,  5 Jun 2015 16:03:29 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9741B.dip0.t-ipconnect.de [79.201.116.27])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t55K3RRS024664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 5 Jun 2015 16:03:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <20150605194200.GB356121@vauxhall.crustytoothpaste.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqDuRoSjUYP0kA4uuK91MFt1T3jJa
	/GjpYbZom/mDyWLz5nYWB1aP5Tf/MnnsnHWX3WPBplKPZ717GD0+b5ILYI3itklKLCkLzkzP
	07dL4M74eW4fc8FftooV/5cxNzAeYe1i5OSQEDCR+PZmISOELSZx4d56ti5GLg4hgcuMEidm
	z2eEcM4xSXT9XsMOUsUroC2x5Nl1JhCbRUBVYu+aS8wgNpuArsSinmagOAeHqECQxOuXuRDl
	ghInZz5hAZkjIrCbUWJV21mwzcICthJfZp9mh1iwl1Hi4N9OsASngIvExmsXwYYyC+hJ7Lj+
	ixXClpfY/nYO8wRG/llIBs9CUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpGermZ
	JXqpKaWbGCHhzLuD8f86mUOMAhyMSjy8DYaFoUKsiWXFlbmHGCU5mJREeXn/A4X4kvJTKjMS
	izPii0pzUosPMUpwMCuJ8O75DZTjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJ
	ynBwKEnwfvwH1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPisr4YmBcgqR4gPZ+
	B2nnLS5IzAWKQrSeYtTluDPl/yImIZa8/LxUKaALQA4XACnKKM2DWwFLXq8YxYE+FuaNBqni
	ASY+uEmvgJYwAS25zloAsqQkESEl1cDo9dekbmeKU2Dl5bmH53LKWCx2DzoY+uXgnkQt5XCP
	BSoTFd3FhTnv6V38dkSd5c26+3Kq6aY++0Izqg3n7pyd26Zu0v4s9q+D9Pr5zz6t 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270887>

On 06/05/2015 09:42 PM, brian m. carlson wrote:
> On Fri, Jun 05, 2015 at 05:22:08PM +0200, Michael Haggerty wrote:
>> I don't know that there would necessarily be problems, but I
>> would worry about code involving structure assignment. For
>> example, suppose the following snippet:
>> 
>> void f(struct object_id *oid) { struct object_id oid_copy =
>> *oid; /* ... */ }
>> 
>> The compiler is allowed to implement the copy using instructions
>> that rely on proper alignment. Such code would fail if oid is not
>> properly aligned.
> 
> We use oidcpy which doesn't use object assignment.  I brought that
> up previously, and Junio was opposed to doing *dest = *src.  So I
> don't think this ends up being an issue.

Sorry for overlooking (or forgetting :-( ) that discussion. Indeed,
that would allay my worry.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90BCF200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeEFXzl (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:55:41 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34936 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeEFXzj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 19:55:39 -0400
Received: by mail-wr0-f174.google.com with SMTP id i14-v6so23377090wre.2
        for <git@vger.kernel.org>; Sun, 06 May 2018 16:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=IyOipgXz3w+kP+52AFeT6e5upjsjHhaeHauMbn66vC8=;
        b=cNbbL09suMYGPGEadkfeP/mT5g8nYx3D2dIamol/LjKavqrwvIJI+9iNUpovJxtTXz
         Bh1uH9AtU4mJAvQXecEqJ7xY+sHG453hYayCJ4IheA533WgKX33TnIUgmxt0/L1ysvp4
         JB8xsXAbEPjwmvxHjzFvMfOFcgCXAZ9j4R4DC54LUa2+v5e7qYNvIGiix5ZNGgZ1wSE9
         8q3jWmnNGgMCJgl4mTNh3Y0nKxPXZV++99IRLZ4M7aZeU1phbw6To43vHuLLTn7AhjKh
         BUsisrKCzmed2wFu/TzQqR7QdEAXnLgHCvbU0nALTl2AYFQ7SSjS57Q/YtLOuRk0ngT+
         QOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=IyOipgXz3w+kP+52AFeT6e5upjsjHhaeHauMbn66vC8=;
        b=fYsAMUuH51mEHv2WznZX89vo7CEaI0e4QutOBJqCmWDejzNbG+UxNl2DWRskLUavhA
         hqRGeLF1wKBn77J3ZuL2aQW0BuxmqkLklY26ZZ1laMMhFcBSfWvM1qAjlerjHgREB/F5
         X5hDk00o/hxFqzxhauINJAepL3iX683uBbvXDITlSynkw/Q4iwg+Bn9XBagLU0Uo5CAI
         A0o8G83CbcBe6izX3WMOOM3pVbteXjQC79bC+lCNcW9a49HC5C0CdimFDab6Evz3+LDe
         pefys2jCX+V1R0KH9u96WFtSygEcnnIhbWhaQSG7glzM+5GBF1ikPI37OpzdYYP+e1/V
         /kHQ==
X-Gm-Message-State: ALQs6tCIWvc9vNVM4VGgb1S1aN/5ktYaHoSDlreBWMrbDErqENRwI8VK
        YK9cl0whQNeROLQZSk1W80s=
X-Google-Smtp-Source: AB8JxZp24N4FU2/9Y1Xk4S/BEAISk6ePdbtCdAyHO5PqxxJwxc07okSnRuEnfg+6RHg0aS5Plptjuw==
X-Received: by 2002:adf:de0c:: with SMTP id b12-v6mr26705634wrm.131.1525650936655;
        Sun, 06 May 2018 16:55:36 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abpx65.neoplus.adsl.tpnet.pl. [83.8.65.65])
        by smtp.gmail.com with ESMTPSA id a13-v6sm20098598wrn.6.2018.05.06.16.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 May 2018 16:55:34 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: [RFC] Other chunks for commit-graph, part 2 - reachability indexes
References: <86zi1fus3t.fsf@gmail.com>
Date:   Mon, 07 May 2018 01:55:30 +0200
In-Reply-To: <86zi1fus3t.fsf@gmail.com> (Jakub Narebski's message of "Fri, 04
        May 2018 21:40:38 +0200")
Message-ID: <86muxcuyod.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

In previous email I wrote:

JN> As this post is getting long, I'll post other ideas, about commit
JN> labeling for faster reachability queries in a separate email.

This is this email.


Here is second part of series dedicated to discussing what other data,
like various reachability indexes / labeling could be added to the
commit-graph file (as new chunks) to make Git even faster.

By reachability I mean answering the question whether commit A can reach
commit B, or in other words if commit B is an ancestor of commit A.
This type of query is used in many Git operations.

The commit-graph has one such reachability index built-in already, in
the form of generation numbers; this index is called level or
topological level of node / vertex in the literature / articles about
graph algorithms.

> 2. The generation number of the commit. Commits with no parents have
>    generation number 1; commits with parents have generation number one
>    more than the maximum generation number of its parents.

I have played a bit with various reachability indexes, starting with the
ones described in "Reachability Queries in Very Large Graphs: A Fast
Refined Online Search Approach" (FELINE index) paper by Ren=C3=AA R. Veloso,
Lo=C3=AFc Cerf, Wagner Meira Jr and Mohammed J. Zaki (2014), available in t=
he
PDF form at https://openproceedings.org/EDBT/2014/paper_166.pdf

I have started working on Jupyter Notebook on Google Colaboratory to
find out how much speedup we can get using those indexes for Git
large-ish commit graphs (which turns out to be quite specific type of
graph, more about which later), namely git.git and Linux kernel ones.

The Jupyter Notebook (which runs on Google cloud, but can be also run
locally) uses Python kernel, NetworkX librabry for graph manipulation,
and matplotlib (via NetworkX) for display.

Available at:
https://colab.research.google.com/drive/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5xyzg
https://drive.google.com/file/d/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5xyzg/view?usp=
=3Dsharing

At current size it started to be a bit unwieldy, especially recomputing
it from the start, so I am thinking about splitting it up and moving it
to GitHub; then I can e.g. put code and data in separate files, so they
do not have to be recalculated (cloning full Linux repository takes
quite a bit of time).  I have started the process: first step which is
copy of Colaboratory notebook is now available as the following repo:
https://github.com/jnareb/git-commit-graph-ext
https://github.com/jnareb/git-commit-graph-ext/blob/master/Graphs_FELINE_in=
dex.ipynb


Let's start with the reminder from part 1:

> Requirements and recommendations about possible new chunks
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Because the main goal of commit-graph feature is better performance in
> large repositories, any proposed new chunks (or, at higher level, every
> proposed piece of new data) needs to have the following properties.
>
>
> 1. First, it needs to have bounded and sensible size.  This means that
> the size of new proposed chunk should be constant, proportional to the
> number of commits, or at worst proportional to the number of edges.
>
> From the existing chunks, OIDF (OID Fanout) has constant size, both OIDL
> (OID Lookup) and CGET/CDAT (Commit Data) has size proportional to the
> number of commits, while not always present EDGE (Large Edge List) has
> size proportional to the number of "excess" edges in "huge vertices"
> (octopus merges).
>
>
> 2. Second, we want fast access, in most cases fast random access.  This
> means using fixed-size records.  All currently existing chunks have
> records (columns) of fixed and aligned size.
>
> This restriction means that idexes where we have variable amount of data
> per vertex (per commit) are discouraged.
>
>
> 3. Third, it needs to be reasonably fast to create, and fast to update.
> This means time to create the chunk to be proportional to number of
> commits, or sum of number of commits and edges (which for commit graph
> and other sparse graphs is proprtional to the number of nodes / commits
> anyway).  In my opinion time proportional to n*lug(n), where 'n' is the
> number of commits, is also acceptable.  Times proportional to n^2 or n^3
> are not acceptable.
>
> It is also strongly preferred that time to update the chunk is
> proportional to the number of new commits, so that incremental
> (append-only) update is possible.  The generation numbers index has this
> property.

Though as =C3=86var said in response, which I agree with:

=C3=86B> If hypothetically there was some data that significantly sped up G=
it
=C3=86B> and the algorithm to generate it was ridiculously expensive, that
=C3=86B> would be fine when combined with the ability to fetch it
=C3=86B> pre-generated from the server. There could always be an option whe=
re
=C3=86B> you trust the server and optionally don't verify the data, or where
=C3=86B> it's much cheaper to verify than compute.

https://public-inbox.org/git/86h8nm2pv8.fsf@gmail.com/T/#mdbc6a4ef052ae9513=
6faf6d243d0c29ddfac58a8


Types of algorithms to speed up reachability queries
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

The [research] issue for answering reachability queries is to find a
tradeoff between the online processing cost and the offline processing
cost.  All different approaches aim to find a trade-off among three main
costs: (a) query time which is the time to answer a reachability query
online [which for Git would be time to perform operation such as `git
branch --contains`], (b) construction time which is the time to
construct an index offline [which for Git would be time for client or
server to create commit-graph file data], and (c) the index size which
is the space needed to maintain the index [which for Git would be the
size of commit-graph file].

We can classify existing works / existing algorithms into two
categories.  The two main approaches are Label-Only and Label+G.  The
Label-Only approach is to answer reachability queries using the labels
computed only (this includes transitive closure compression and hop
labeling / transitive closure factorization methods).  The Label+G
approach is to make use of the labels computed as much as possible, but
it may need to traverse the graph G (it also called refined online
search).  The main idea behind Label+G is to reduce the time to
construct an effective index, since the computing cost to create
effective Label-Only index can be very high.

Note: this categorization is taken from the IP paper.

Beside those two groups there also exists so called boosting frameworks.
This algorithms try to reduce answering reachability query on very large
graph to answering reachability queries on smaller graph (reachability
backbone in case of SCARAB framework, reduced/simplified graph in case
of DAG Reduction method).

Let's table boosting frameworks for later (for example to examine
whether SCARAB could be used to choose which commits should have
reachability bitmaps).  If we follow "Requirements and recommendations
about possible new chunks", then we can limit examinations to Label+G
approaches.  Besides, commit-graphs can get large enough so that
Label-Only approaches starts to get unfeasible: index creation time and
index size gets very large.


Commit graph characteristics
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

But first lets try to address the elephant in the room: would those
algorithms work well for the graph of revisions?

These methods are usually evaluated on a variety of real graph datasets,
both small and large, as well as large synthetic ones.  The real graphs
datasets include XML documents, genome databases, citation networks,
semantic knowledge databases and ontology terms, taxonomies, social
networks and web graphs.

It turns out that graph of revisions has size (number of nodes) that for
large repositories number of commits/nodes (50k for git.git, 750k for
Linux kernel, 1.7M for MS Windows) falls somewhere in the middle between
size of small graphs with 6k to 40k nodes and size of large graphs, most
of which has number of nodes staring from 1.5M and bigger.

Many of those example graphs (that are used for evaluation of
reachability algorithms) are approximately scale-free, with relative
commonness of vertices with a degree that greatly exceeds the average --
which is not the case for graph of revisions.  Some approaches include
special handling for those vertices to speed up queries; this probably
is not needed for DAG of commits, and I will skip these parts for now.

Commit graphs are sparse graphs, with average number of parents (the
ratio of edges to nodes in graph) below 2.0; even closer to 1.

One major difference is that in those graphs the percentage of
reachability queries that are answered negatively over all possible
reachability queries is over 90%.  On the other hand, the ratio of
reachability queries that are answered positively over all possible
reachability queries is very small; this ratio is called
reachability-ratio (or simply R-ratio), usually denoted as 'r'.  For
those real graph datasets, the R-ratio is between 2.1e-1 to 1.3e-7.  But
for graph of revision (based on sample of one) it looks like this
R-ratio is around 4.5e-1 (with, if I am not mistaken, maximum R-ratio
possible in DAGs being 0.5 or 5.0e-1, that is 50%).  This may affect the
evaluation of method for commit graphs; on the other hand as positive
queries are more interesting, some works do evaluations separately in
positive and negative queries, or on equal mixure of positive and
negative queries.

Another issue is that many of those "evaluation" graphs usually have the
large number of sources (nodes with only outgoing edges, "roots" in
graph terminology, "tips" or "heads" in Git terminology -- childless
nodes) or/and the large number of sinks (nodes with no outgoing edges,
"leafs" in graph terminology, "roots" in Git terminology -- parentless
nodes).  This seems to matter for FELINE index, which as my experiments
in mentioned Jupyter notebook shows is much less efective on commit
graphs than indicated in original work.  Note that while live
repositories would have much larger amount of branches than public
repositories (that I have used for tests) where there are only a few
long-lived public branches, even for Windows repo it is small percentage
of total number of nodes / commits (the Windows repo according to the
Git Merge 2018 presentation by Derrick has 90k branches and 1700k
commits; it is not as where 1/4 of nodes were source nodes).


Negative and positive-cut filters, false negatives and false positives
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

In Label+Graph approaches, indexing (node/edge labels) is enough to
answer some queries in constant time.

If the indexing can answer positive queries in constant time we call it
_positive-cut filter_.  This means that querying the index can state
that node B is reachable from node A (positive result); reaachability is
guaranteed.  However if we don't get such answer from the index, we
don't know if B is reachable from A, or if B is not reachable from A.
The case where B is reachable from A, but the index doesn't say it, we
can call _false negatives_: we get negative answer from the index, while
the actual ressult of reachability query is positive.

If the indexing can answer negative queries in constant time we call it
_negative-cut filter_.  This means that querying the index can state
that node B is definitevly not reachable from node A (negative result).
Otherwise we don't know if B is or is not reachable from A.  The case
where there is no path from A to B, but the index doesn't say it, we can
call _false positives_ or _falsely-implied path_.

Generation numbers (or topological levels) are an example of negative
cut filter.  If gen(A) < gen(B) then A cannot reach B.

Note: The terminology used here is taken from the FELINE paper (which
does not necesarily mean that it originated here; it appears in earlier
GRAIL paper too).

When one wants just to find if there exist path from A to B, both
positive-cut and negative-cut filters can be used.

  Data: (u, v) =E2=88=88 V^2, two vertices of the DAG
  Result: r(u, v), whether v is reachable from u
  Note: simplified DFS algorithm, no visited filter
  begin
      if positive-cut(u, v) then
          return true;
      if u =3D=3D v then
          return true;
      if not negative-cut(u, v) then
          forall the w =E2=88=88 parents(u) do
              if Reachable(w, v) then
                  return true;

      return false;

This is the case for '--contains' and '--merged' queries in Git.

When one wants to find a single path from A to B if it exists, then both
negative-cut and most positive-cut filters can be used.

When one wants to find out all paths from A to B (e.g. for `git log A ^B
--strict-ancestor`) then in most cases only negative-cut filters are
really useful.


Online search algorithms
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

When the index or indexes used cannot answer reachability query by
itself, one needs to perform a search from the source node to the target
node, applying positive-cut and negative-cut filters to reduce search
space.

One possible solution, often used for rechability testing in various
works, is to perform depth-first search (DFS).  This can be done simply
by using recursion (like in the above pseudo-code), but for large graphs
one need to use iterative approach by employing stack.  DFS is needed to
compute some of the reachability indexes.

However DFS it is not always the best strategy. Breadth-first search
(BFS) guarantees to find the shortest path with the cost of using more
memory.  In average, BFS is expected to be faster considering the cases
where the target node is close to the source node that has a large
reachability set.  This is especially true for graphs of revisions, that
are deep but narrow (their width is much smaller than their depth;
maximum number of commits with the same generation number is much
smaller than maximum generation number).  In BFS we store nodes to be
walked in a queue.

Besides the standard graph search strategies of DFS and BFS, sometimes
there is also considered bidirectional breadth-first search (BBFS),
which has a few advantages over BFS. In bidirectional search two BFS are
started simultaneously utilizing separate queues: one starting from
source node and going forward, and one starting from target node and
going backward (walking the reverse of DAG).  The first advantage of
bidirectional search is that it can answer positive queries faster when
the average degree of the graph is high. In negative queries, the worst
case scenario is that bidirectional search takes twice as much time as a
BFS would take; however there are substantial amount of cases where
bidirectional search is much faster than BFS.

Some indexes are geared towards making BBFS faster; this needs to be
taken into account when evaluating them, as we would not want to have to
deal with reversed commit graph.

Git actually uses a variant of BFS in paint_down_to_commin() in
commit.c, where it uses priority queue, sorted by generation number then
by date.  We can say that it is closest-first search variant of BFS.


Reachability indexes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The Label+Graph approaches to include the following algorithms to speed
up reachability queries:

- Tree+SPPI (2005)
  (Surrogate & Surplus Predecessor Index)
- GRIPP (2007)
  (GRaph Indexing based on Pre- and Postorder numbering)
+ GRAIL (2010 & 2012)
  (Graph Reachability indexing via rAndomized Interval Labeling)
* PReaCH (2014)
  (Pruned Reachability Contraction Hierarchies)
+ FERRARI (2013)
  (Flexible and Efficient Reachability Range Assignment for gRaph Indexing)
+ FELINE (2014)
  (Fast rEfined onLINE search)
+ IP (2014)
  (Independent Permutation labeling approach)
+ BFL (2016)
  (Bloom Filter Labeling)

Algorithms prefixed with '-' are those older ones usually compared
against in different works that I won't cover here while algorithms
prefixed with '+' are those that I will cover somewhat.  Algorithms
prefixed with '*' are less known works that I think might be
interesting.


Levels / generation numbers
---------------------------

One of the simplest negative-cut filters, used by almost all works as a
supplementary filter... and also by Git's commit-graph feature.  The
generation number, or [topological] level is defined as length of
shortest path from a sink node ("root" in Git terminology).  You can also
define "reverse" or "backward" levels starting from source nodes, and
some works use that.

More useful in actually computing generation number for a commit, or
level of a node is recursive definition given at the beginning of this
email.  Note that usually nodes without outgoing edges ("root" nodes)
are assigned level zero, but giving it value of one like commit-graph
feature does is also valid convention.

The recursive definition shows that it is possible to calculate
generation numbers incrementally.  In particular the cost of updating
generation numbers is proportional to the number of new commits.  This
is not the case for "reverse" level numbers -- we won't consider it
then.

Generation numbers / topological levels are denoted using gen(B) symbol
in commit-graph documentation and commit messages, and l_u or L(u) in
works about graph reachability algorithms.  Let's use gen(A) here.

The following holds true:

  If A can reach B, and A !=3D B, then gen(A) > gen(B)

This means that we get the following negative cut condition (this
condition is equivalent to the one above):

  If gen(A) <=3D gen(B) and A !=3D B, then A cannot reach B

Sometimes it is easier to make use of the weaker negative-cut condition:

  If gen(A) < gen(B), then A cannot reach B


Topological ordering
--------------------

A topological sort or topological ordering of a directed acyclic graph
is a linear ordering of its vertices such that for every directed edge
(u,v) from vertex u to vertex v, u comes before v in the ordering.  Any
DAG has at least one topological ordering, and algorithms are known for
constructing a topological ordering of any DAG in linear time.

A topological ordering should be able to be updated quite easily, while
the reverse topological ordering should be able to be updated in time
proportional to the number of added commits (though there are no
guarantees about properties of such topological order).

The following holds true:

  If A can reach B, and A !=3D B, then topo(A) > topo(B)
  If A can reach B, then topo(A) >=3D topo(B)

Because this is ordering, we also have that if topo(A) <=3D topo(B) and
topo(A) >=3D topo(B), then A =3D B; if topo(A) =3D topo(B) then A =3D B.

This means that we have the following negative-cut condition:

  If topo(A) < topo(B), then A cannot reach B

The condition is reversed for the reverse topological ordering.

Note: The FELINE index can be thought of as composed of two topological
ordering, where the second ordering is constructed using heuristic
algorithm in such way that it tries to minimize number of false
positives (falsely-implied paths) for the combination of those two
topological sort negative-cut filters.


Post-order in spanning tree
---------------------------

Directed rooted tree is a directed graph in which, for a vertex u called
the [tree] root and any other vertex v, there is exactly one directed
path from u to v.  A spannig tree of a directed acyclic graph G is a
subgraph that is a tree or set of trees (directed rooted tree for DAG)
which includes all of the vertices of graph G.  Source nodes of G are
roots of spanning trees of G.

The reachability problem on trees can be solved effectively by interval
labeling, which takes linear time and space for constructing the index,
and provides constant time querying.  Given a tree/forest T, interval
labeling assigns each node a label I(u) =3D [s_u, e_u] which represents
interval starting at s_u and ending at e_u.  A desired labeling
suitable for answering reachability queries in trees must satisfy the
condition that I(u) subsumes I(v), or in other words interval I(v) is a
subset of interval I(v) if and only if u reaches v.

One such labeling is _min-post labeling_ method for trees.  In this
labeling e_u =3D post(u) is the post-order value of the node u, defined as
the rank of the node u in a post order traversal of the tree.  The
starting value of the interval s_u is defined as the lowest post-order
rank for any node x in the subtree rooted at u (i.e., including u).
Note that because of how this interval was defined the check
I(v) =E2=8A=86 I(u) can be replaced by simpler post(v) =E2=88=88 I(u).

Pre order traversal of tree gives _pre-max labeling_ method for trees,
exactly equivalent to the min-post labeling described above.

This method used for a spanning tree gives positive-cut filter: if it
gives positive results for u ---> v query, then node v is reachable from
u via spanning tree.  If the answer from spanning tree labeling is
negative, node v can still be reachable from u, but via non-tree edge.
This is the idea behind positive-cut filter in GRAIL method, and this is
also positive-cut filter used in FELINE work/paper.  GRAIL calls this
positive-cut interval an interior interval.


The post-order or pre-order labeling of spanning tree is also labeling
of nodes in the original DAG.  Hence for negative-cut filter we can
assign to each node u the interval starting at minimum of labels of
nodes reachable in the DAG from u, and ending at maximum of labels of
nodes reachable in the DAG from u.  Then if node v has label outside
this interval I'(u), then u cannot reach v.  GRAIL calls this
negative-cut interval an exterior interval.

Now if the traversal of tree was done using DFS (depth-first search),
then the ending of min-post interval I(u) for a spanning tree is also
end of interval I'(u) for DAG.  Moreover the minimum of post(v) for
nodes reachable from u, that is the starting point for the DAG interval,
can be calculated iteratively during post-order traversal of the tree.
(It is possible that DFS is not needed; PReaCH work proves it for DFS,
but I have not examined proof in GRAIL work in detail).  GRAIL approach
uses those two intervals together: the interval label for node u is
given as I(u) =3D [s_u, m_u, e_u ], where EI(u) =3D [s_u, e_u] and
II(u) =3D [m_u, e_u] are the exterior (negative-cut) and interior
(positive-cut) intervals respectively.

The motivating idea in GRAIL is to use interval labeling multiple times,
for multiple random spaanning trees to improve searching phase
(answering reachability queries).  The GRAIL work proposes several
heuristics how to choose best set of spanning trees.  The recommended
number of those trees for large graphs is k =3D 5.

Using multiple spanning trees is not the only solution.  Alternative is
trying to get more out of single DFS numbering.  PReaCH work
(arXiv:1404.4465) adds one more possible and possibly large positive-cut
interval (called "full" interval there), and possibly one more
negative-cut interval (called "empty" interval).  Note that the original
work uses pre-order numbering and pre-max intervals, but the result can
be easily translated to post-numbering and min-post intervals (I have
done this in mentioned Jupyter notebook).

The additional positive-cut interval for node u, if it exists, is the
positive-cut interval for a node w =3D p_tree(u) that is reachable from u
and not in positive-cut interval of u, and has maximum size of said
positive-cut interval.  This can be computed iteratively, while
computing post-number ordering on u.  This seems promising for graph of
revisions.

One can also find additional negative-cut interval, finding f_gap so
that [f_gap, min] is "empty" interval, and the negative cut is split
from [f_min, post] to two intervals: [f_min, f_gap] and [min, post].
This also can be computed iteratively.


The FERRARI approach is more generic.  It starts with the fact that the
reachable set R(v) of a vertex v in the DAG is only partly represented
by the spanning tree interval I_T(v), as the tree interval only accounts
for reachability relationships that are preserved in tree T.  The
reachable set R(v) can be represented as set of intervals II(v).  The
resulting index (collection of reachable interval sets) can be regarded
as a materialization of the transitive closure of the graph, which gets
too large and is thus infeasible for large graphs.

Instead of storing full set of intervals II(v) representing reachability
set R(v), FERRARI index assigns a mixture of exact and approximate
reachability intervals, given a user-specified size constraint on the
index.  In FERRARI-L (local version) it is replaced by at most k
intervals, some of which come from II(v) and some are merges of
intervals from II(v).  If node w is in one of exact intervals for node
v, then v can reach w; if node w is outside all of intervals for node v,
then v cannot reach w.  Intervals are chosen in such way as to maximize
the sum of sizes of exact intervals, maximizing positive-cut
effectiveness.

In FERRARI-G variant the user-specified size constraint is made global;
some nodes may use more intervals, and some less, keeping the average
constant.  This allows to use index space more effectively, at the cost
of variable-length index and slower access.


Contraction hierarchies
-----------------------

In general, a Reachability Contraction Hierarchy (RCH) can be defined
based on any numbering order. We successively contract nodes with
increasing order(v). Contracting node v means removing it from the graph
and possibly inserting new edges such that the reachability relation in
the new graph is the same as in the previous graph, The query algorithm
does not use the contracted versions of the graph but only the ordering
and the shortcuts. This algorithm is based on the observation that in an
RCH it suffices to look at "up-down" paths, with contraction order first
increasing, then decreasing; this works best with bidirectional breadth
first search (BBFS).

PReaCH approach exploits the fact that any DAG contains source nodes
(with in-degree zero) and sink nodes (with out-degree zero). Contracting
such a node v never requires the insertion of shortcuts.

The index in this case is just one number per node: the contraction
order.  I'm not sure how useful that would be for BFS search, without
accessing reverse graph.


Graph dominance drawing
-----------------------

The fundamental idea behind FELINE is to associate every vertex u in V
with a unique ordered pair of natural integers i(u), so that if vertex u
can reach v, then i(u) =E2=89=A6 u(v), that is first element is less or equ=
al
first element in pair, and second element is less or equal second
element in pair.  If this pair of integers (x, y) associated with a
vertex is understood as coordinates in the Cartesian plane, then the
implication means that paths always point right and up, and it is enough
to check uper-right quadrant.

The method is inspired by weak dominance drawing, which guarantees the
implication for edges.  FELINE work shows proof that this leads to the
implication for paths.

Such pair of numbers are negative-cut filter.  The algorithm for
creating such index in FELINE work uses two topological orderings, where
the second is choosen to minimize number of false positives for the
index.

It turns out however from the experiments in mentoned Jupyter notebook
that this method doesn't work that well with commit graphs.  When there
are only a few sources and only a few sinks, then node positions gather
around 'x =3D y' diagonal line, thus FELINE index check almost reduces to
the topological ordering filter mentioned earlier.


Approximate set inclusion
-------------------------

Both IP and BFL takes reachability testing from a vertex u to a vertex v
as set-containment testing. Intuitively, if a vertex u can reach a
vertex v, then u must be able to reach all the vertices that v can
reach. Let Out(x) denote the set of all vertices that a vertex x can
reach in a graph. If u can reach v, then Out(v) =E2=8A=86 Out(u).  This is =
done
by checking by checking Out(v) =E2=8A=88 Out(u) instead (that Out(v) is not
subset or equal to Out(u), which is to check if there is at least one
element in Out(v) that is not in Out(u).

Both instead of getting an exact answer for testing, they get an answer
with given probability guarantee in a negative-cut fashion.  The IP
label uses k-min-wise independent permutations, while BFL uses Bloom
filters.

Those approaches work well with graphs that have not large reachability
sets (short depth), and where ratio of positive queries to all queries
is very small.  This means that they would most probably won't work well
for commit graphs, where neither holds true.


Summary
=3D=3D=3D=3D=3D=3D=3D

The min-post labeling (the base of GRAIL approach) looks promising; it
needs to be checked whether PReaCH approach or FERRARI approach be
better for commit graphs.

I hope that this somewhat long post was informative,
--=20
Jakub Nar=C4=99bski
